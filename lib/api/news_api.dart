import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/api/failure.dart';

import 'news_model.dart';

class NewsApi {
  final String url =
      "https://newsapi.org/v2/everything?q=bitcoin&pageSize=10&apiKey=261a68fc65d14243bb91c8d62dc1f557";
  Dio client = Dio(BaseOptions(
    connectTimeout: 60000,
    // receiveTimeout: 60000,
  ));
  // BaseOptions baseOptions = BaseOptions(
  //   connectTimeout: 5000,
  //   receiveTimeout: 5000,
  // );
  Future<Either<List<NewsEntity>, Failure>> getBitCoinNews(
      String pageSize) async {
    try {
      Response res = await client.get(
          "https://newsapi.org/v2/everything?q=bitcoin&pageSize=$pageSize&apiKey=261a68fc65d14243bb91c8d62dc1f557");

      if (res.statusCode == 200) {
        List<NewsEntity> newsList = News.newsList(res.data);
        return Left(newsList);
      }
      return const Right(Failure(message: "Unknown error"));
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          return const Right(Failure(message: "connect timeout"));
        case DioErrorType.sendTimeout:
          return const Right(Failure(message: "send time out"));
        case DioErrorType.receiveTimeout:
          return const Right(Failure(message: "Receive timeout"));
        case DioErrorType.response:
          return const Right(Failure(message: "response error"));
        case DioErrorType.cancel:
          return const Right(Failure(message: "Cancel"));
        case DioErrorType.other:
          return const Right(
              Failure(message: "Your are not connected to the internet"));
      }
    }
  }
}
