import 'package:hive/hive.dart';

import '../../Domain/enities.dart';

class LocalDataSource {
  Future<void> storeNews(
      {required List<NewsEntity> newsList, required String boxName}) async {
    final newsBox = await Hive.openBox<NewsEntity>(boxName);
    await newsBox.clear();
    await newsBox.addAll(newsList);
    await newsBox.close();
  }

  Future<List<NewsEntity>?> getNews({required String boxName}) async {
    final newsBox = await Hive.openBox<NewsEntity>(boxName);
    if (newsBox.isEmpty) {
      return null;
    } else {
      final data = newsBox.keys.map((key) => newsBox.get(key)!).toList();
      return data;
    }
  }
}
