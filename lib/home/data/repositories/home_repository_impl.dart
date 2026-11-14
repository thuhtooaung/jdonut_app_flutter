import '../../domain/models/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<HomeDataEntity> getHomeData() async {
    try {
      final remoteModel = await remoteDataSource.getHomeData();
      await localDataSource.cacheHomeData(remoteModel);
      return remoteModel.toEntity();
    } catch (e) {
      final cachedModel = await localDataSource.getCachedHomeData();
      if (cachedModel != null) {
        return cachedModel.toEntity();
      }
      rethrow;
    }
  }
}
