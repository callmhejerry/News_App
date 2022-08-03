import 'package:hive/hive.dart';

import '../../../Domain/enities.dart';
import '../local_data_source.dart';

class EntertainmentLocalDataSource implements ILocalDataSource {
  @override
  Future<void> storeAllNews({required List<NewsEntity> newsList}) async {
    final newsBox = Hive.box<NewsEntity>("Entertainment-news");
    await newsBox.clear();
    await newsBox.addAll(newsList);
  }

  @override
  Future<List<NewsEntity>?> getAllNews() async {
    final newsBox = Hive.box<NewsEntity>("Entertainment-news");
    if (newsBox.isEmpty) {
      return null;
    } else {
      final data = newsBox.keys.map((key) => newsBox.get(key)!).toList();
      return data;
    }
  }

  @override
  Future<void> storeHeadlineNews({
    required List<HeadLineEntity> newsList,
  }) async {
    final newsBox = Hive.box<HeadLineEntity>("headline-Entertainment");
    await newsBox.clear();
    await newsBox.addAll(newsList);
  }

  @override
  Future<List<HeadLineEntity>?> getHeadlineNews() async {
    final newsBox = Hive.box<HeadLineEntity>("headline-Entertainment");
    if (newsBox.isEmpty) {
      return null;
    } else {
      final data = newsBox.keys.map((key) => newsBox.get(key)!).toList();
      return data;
    }
  }
}
