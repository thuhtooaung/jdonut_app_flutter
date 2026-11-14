import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:jdonut_app_flutter/detail/product_detail_screen.dart';
import 'package:jdonut_app_flutter/home/data/datasources/home_local_data_source.dart';
import 'package:jdonut_app_flutter/home/data/datasources/home_remote_data_source.dart';
import 'package:jdonut_app_flutter/home/data/models/home_data_model.dart';
import 'package:jdonut_app_flutter/home/data/repositories/home_repository_impl.dart';
import 'package:jdonut_app_flutter/home/presentation/models/product_args.dart';
import 'package:jdonut_app_flutter/home/presentation/screens/home_screen.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';

class MockRemoteDataSource implements HomeRemoteDataSource {
  bool shouldThrow = false;
  final HomeDataModel modelToReturn;

  MockRemoteDataSource({required this.modelToReturn, this.shouldThrow = false});

  @override
  Future<HomeDataModel> getHomeData() async {
    if (shouldThrow) {
      throw Exception('Network error');
    }
    return modelToReturn;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
  });

  setUp(() async {
    if (!Hive.isBoxOpen('home_cache')) {
      await Hive.openBox<Map>('home_cache');
    }
  });

  tearDown(() async {
    if (Hive.isBoxOpen('home_cache')) {
      await Hive.box<Map>('home_cache').clear();
    }
  });

  group('Home Clean Architecture Offline-First Caching Tests', () {
    test('Remote Data Source returns valid JSON response models', () async {
      final dataSource = HomeRemoteDataSourceImpl();
      final model = await dataSource.getHomeData();

      expect(model.promoBanners, isNotEmpty);
      expect(model.seasonalSpecials, isNotEmpty);
      expect(model.popularItems, isNotEmpty);
      expect(model.orderAgainItems, isNotEmpty);
      expect(model.nearbyShops, isNotEmpty);
    });

    test('Local Data Source caches and retrieves model correctly using Hive CE', () async {
      final box = await Hive.openBox<Map>('test_home_cache');
      final localDataSource = HomeLocalDataSourceImpl(cacheBox: box);

      final remoteSource = HomeRemoteDataSourceImpl();
      final model = await remoteSource.getHomeData();

      await localDataSource.cacheHomeData(model);
      final cached = await localDataSource.getCachedHomeData();

      expect(cached, isNotNull);
      expect(cached!.promoBanners.length, equals(model.promoBanners.length));
      expect(cached.seasonalSpecials.first.title, equals(model.seasonalSpecials.first.title));

      await box.clear();
      await box.close();
    });

    test('Repository fetches from remote, caches data, and returns domain entities', () async {
      final box = await Hive.openBox<Map>('test_home_cache_repo');
      final localDataSource = HomeLocalDataSourceImpl(cacheBox: box);
      final remoteDataSource = HomeRemoteDataSourceImpl();

      final repository = HomeRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
      );

      final entity = await repository.getHomeData();
      expect(entity.promoBanners, isNotEmpty);

      // Verify cached
      final cached = await localDataSource.getCachedHomeData();
      expect(cached, isNotNull);

      await box.clear();
      await box.close();
    });

    test('Repository falls back to local cache when remote fails (Offline-First mode)', () async {
      final box = await Hive.openBox<Map>('test_home_cache_fallback');
      final localDataSource = HomeLocalDataSourceImpl(cacheBox: box);

      final remoteSource = HomeRemoteDataSourceImpl();
      final validModel = await remoteSource.getHomeData();

      // Pre-cache data
      await localDataSource.cacheHomeData(validModel);

      // Setup failing remote source
      final failingRemote = MockRemoteDataSource(
        modelToReturn: validModel,
        shouldThrow: true,
      );

      final repository = HomeRepositoryImpl(
        remoteDataSource: failingRemote,
        localDataSource: localDataSource,
      );

      // Should succeed using local cache fallback
      final entity = await repository.getHomeData();
      expect(entity.promoBanners, isNotEmpty);
      expect(entity.seasonalSpecials.first.title, equals(validModel.seasonalSpecials.first.title));

      await box.clear();
      await box.close();
    });
  });

  group('Home Screen Presentation Tests', () {
    testWidgets('Renders Home Screen and navigates to ProductDetailScreen on item tap',
        (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: Routes.main,
        routes: [
          GoRoute(
            path: Routes.main,
            builder: (context, state) => const Scaffold(body: HomeScreen()),
          ),
          GoRoute(
            path: Routes.product,
            builder: (context, state) => ProductDetailScreen(
              args: state.extra is ProductArgs ? state.extra as ProductArgs : null,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Advance timer for delayed mock API call
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump();

      expect(find.text('Seasonal specials'), findsOneWidget);

      // Scroll slightly down so seasonal items are inside screen bounds
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -250));
      await tester.pump();

      // Tap on Seasonal special item
      final seasonalItem = find.text('Mistletoe\nRomance box');
      expect(seasonalItem, findsOneWidget);
      await tester.tap(seasonalItem);
      await tester.pump();

      // Verify ProductDetailScreen is pushed with ProductArgs
      expect(find.text('Mistletoe Romance box'), findsOneWidget);
      expect(find.text('50% off'), findsOneWidget);
    });
  });
}
