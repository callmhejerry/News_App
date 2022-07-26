import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/Data/DataSources/local_data_source.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/utils/internet_checker.dart';

import '../Domain/news_repo.dart';
import '../utils/failure.dart';

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
  Future<Either<List<NewsEntity>, Failure>> getAllNews(newsCount) async {
    bool isConnected = await internetConnection.isConnected();
    //USE THE ISCONNECTED TO DECIDE WHETHER TO RETURN FROM DATASOURCE OR NOT
    if (isConnected) {
      debugPrint(isConnected.toString());
      try {
        final result = await newsRemoteDataSource.getAllNews(newsCount);
        await newsLocalDataSource.storeNews(
            newsList: result, boxName: "bitcoin");
        return Left(result);
      } on DioError catch (e) {
        final result = await newsLocalDataSource.getNews(boxName: "bitcoin");
        if (result != null) {
          return Left(result);
        }
        if (e.type == DioErrorType.connectTimeout) {
          debugPrint("From remote source");
          return const Right(Failure(message: "Please check your connection"));
        } else {
          return const Right(Failure(message: "server Error"));
        }
      }
    } else {
      final result = await newsLocalDataSource.getNews(boxName: "bitcoin");
      if (result == null) {
        return const Right(Failure(message: "No internet connection"));
      } else {
        return Left(result);
      }
    }
  }

  @override
  getHeadlineNews() {}
}
