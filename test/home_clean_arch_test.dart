import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/detail/product_detail_screen.dart';
import 'package:jdonut_app_flutter/home/data/datasources/home_fake_data.dart';
import 'package:jdonut_app_flutter/home/data/repositories/home_repository_impl.dart';
import 'package:jdonut_app_flutter/home/domain/usecase/get_home_data_usecase.dart';
import 'package:jdonut_app_flutter/home/presentation/models/product_args.dart';
import 'package:jdonut_app_flutter/home/presentation/screens/home_screen.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';

void main() {
  group('Home Clean Architecture Data & Domain Tests', () {
    test('Local Data Source returns valid JSON response models with placeholder image',
        () async {
      final dataSource = HomeLocalDataSourceImpl();
      final model = await dataSource.getHomeData();

      expect(model.promoBanners, isNotEmpty);
      expect(model.seasonalSpecials, isNotEmpty);
      expect(model.popularItems, isNotEmpty);
      expect(model.orderAgainItems, isNotEmpty);
      expect(model.nearbyShops, isNotEmpty);

      expect(
        model.promoBanners.first.imageUrl,
        equals(
            'https://images.pexels.com/photos/23203429/pexels-photo-23203429.jpeg'),
      );
    });

    test('Repository and Use Case return mapped domain entities', () async {
      final dataSource = HomeLocalDataSourceImpl();
      final repository = HomeRepositoryImpl(localDataSource: dataSource);
      final useCase = GetHomeDataUseCase(repository: repository);

      final entity = await useCase.execute();

      expect(entity.promoBanners.length, equals(2));
      expect(entity.seasonalSpecials.length, equals(3));
      expect(entity.popularItems.length, equals(3));
      expect(entity.orderAgainItems.length, equals(3));
      expect(entity.nearbyShops.length, equals(3));

      expect(entity.promoBanners.first.title, contains('Central Boulevard'));
      expect(entity.seasonalSpecials.first.title, contains('Mistletoe'));
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
