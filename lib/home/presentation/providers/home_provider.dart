import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/home_local_data_source.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/models/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecase/get_home_data_usecase.dart';

part 'home_provider.g.dart';

@riverpod
Box<Map> homeCacheBox(Ref ref) {
  return Hive.box<Map>('home_cache');
}

@riverpod
HomeRemoteDataSource homeRemoteDataSource(Ref ref) {
  return HomeRemoteDataSourceImpl();
}

@riverpod
HomeLocalDataSource homeLocalDataSource(Ref ref) {
  final box = ref.watch(homeCacheBoxProvider);
  return HomeLocalDataSourceImpl(cacheBox: box);
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  final remoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  final localDataSource = ref.watch(homeLocalDataSourceProvider);
  return HomeRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}

@riverpod
GetHomeDataUseCase getHomeDataUseCase(Ref ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetHomeDataUseCase(repository: repository);
}

@riverpod
Future<HomeDataEntity> homeData(Ref ref) async {
  final useCase = ref.watch(getHomeDataUseCaseProvider);
  return useCase.execute();
}
