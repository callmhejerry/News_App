import 'package:dartz/dartz.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/internet_checker.dart';

import '../Domain/news_repo.dart';
import '../api/failure.dart';

class NewsRepo implements INewsRepo {
  final RemoteDataSouce newsRemoteDataSource;
  final InternetConnection internetConnection;

  const NewsRepo({
    required this.newsRemoteDataSource,
    required this.internetConnection,
  });
  @override
  Future<Either<List<NewsEntity>, Failure>> getBitCoinNews(newsCount) async {
    //USE THE ISCONNECTED TO DECIDE WHETHER TO RETURN FROM DATASOURCE OR NOT
    Either<List<NewsEntity>, Failure> result =
        await newsRemoteDataSource.getBitCoinNews(newsCount);
    return result;
  }
}
