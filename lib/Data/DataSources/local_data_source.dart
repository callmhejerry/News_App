import '../../Domain/enities.dart';

abstract class ILocalDataSource {
  Future<void> storeAllNews({required List<NewsEntity> newsList});
  Future<List<NewsEntity>?> getAllNews();
  Future<void> storeHeadlineNews({
    required List<HeadLineEntity> newsList,
  });
  Future<List<HeadLineEntity>?> getHeadlineNews();
}
