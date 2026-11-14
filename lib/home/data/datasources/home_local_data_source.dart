import 'package:hive_ce/hive_ce.dart';
import '../models/home_data_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeDataModel?> getCachedHomeData();
  Future<void> cacheHomeData(HomeDataModel model);
  Future<void> clearCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Box<Map> cacheBox;
  static const String _cacheKey = 'cached_home_data';

  HomeLocalDataSourceImpl({required this.cacheBox});

  @override
  Future<HomeDataModel?> getCachedHomeData() async {
    final dynamic jsonMap = cacheBox.get(_cacheKey);
    if (jsonMap == null) return null;
    try {
      final convertedMap = Map<String, dynamic>.from(
        jsonMap.map((key, value) => MapEntry(key.toString(), value)),
      );
      return HomeDataModel.fromJson(convertedMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheHomeData(HomeDataModel model) async {
    await cacheBox.put(_cacheKey, model.toJson());
  }

  @override
  Future<void> clearCache() async {
    await cacheBox.delete(_cacheKey);
  }
}
