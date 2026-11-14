import '../../domain/models/home_data_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_fake_data.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<HomeDataEntity> getHomeData() async {
    final model = await localDataSource.getHomeData();
    return model.toEntity();
  }
}
