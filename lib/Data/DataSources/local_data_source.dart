import 'package:flutter/foundation.dart';
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
      debugPrint("empty box");
      return null;
    } else {
      debugPrint("filled box");
      final data = newsBox.keys.map((key) => newsBox.get(key)!).toList();
      return data;
    }
  }
}
