import '../models/home_data_entity.dart';

abstract class HomeRepository {
  Future<HomeDataEntity> getHomeData();
}
