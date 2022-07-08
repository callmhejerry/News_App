import 'package:dartz/dartz.dart';
import 'package:news_app/Data/DataSources/local_data_source.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/internet_checker.dart';

import '../Domain/news_repo.dart';
import '../api/failure.dart';

class NewsRepo implements INewsRepo {
  final RemoteDataSouce newsRemoteDataSource;
  final LocalDataSource newsLocalDataSource;
  final InternetConnection internetConnection;

  const NewsRepo({
    required this.newsRemoteDataSource,
    required this.newsLocalDataSource,
    required this.internetConnection,
  });
  @override
  Future<Either<List<NewsEntity>, Failure>> getBitCoinNews(newsCount) async {
    //USE THE ISCONNECTED TO DECIDE WHETHER TO RETURN FROM DATASOURCE OR NOT
    if (internetConnection.isConnected) {
      try {
        List<NewsEntity> newsList =
            await newsRemoteDataSource.getBitCoinNews(newsCount);
        await newsLocalDataSource.storeNews(
            boxName: "bitcoin", newsList: newsList);
        return Left(newsList);
      } catch (e) {
        final result = await newsLocalDataSource.getNews(boxName: "bitcoin");
        if (result == null) {
          return const Right(
              Failure(message: "You dont have an internet connection"));
        } else {
          return Left(result);
        }
      }
    } else {
      final result = await newsLocalDataSource.getNews(boxName: "bitcoin");
      return Left(result!);
    }
  }
}
