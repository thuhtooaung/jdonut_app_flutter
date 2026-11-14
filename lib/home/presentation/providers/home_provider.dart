import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/home_fake_data.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/models/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecase/get_home_data_usecase.dart';

part 'home_provider.g.dart';

@riverpod
HomeLocalDataSource homeLocalDataSource(Ref ref) {
  return HomeLocalDataSourceImpl();
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  final dataSource = ref.watch(homeLocalDataSourceProvider);
  return HomeRepositoryImpl(localDataSource: dataSource);
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
