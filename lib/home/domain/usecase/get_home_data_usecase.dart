import '../models/home_data_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase({required this.repository});

  Future<HomeDataEntity> execute() async {
    return await repository.getHomeData();
  }
}
