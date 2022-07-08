import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/Domain/enities.dart';

import '../../api/failure.dart';
import '../../api/news_model.dart';

class RemoteDataSouce extends ApiClient {
  Future<Either<List<NewsEntity>, Failure>> getBitCoinNews(
      String pageSize) async {
    try {
      Response res = await dio.get(
        "/everything",
        queryParameters: {
          "q": "bitcoin",
          "pageSize": pageSize,
        },
      );

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
            Failure(
              message: "Your are not connected to the internet",
            ),
          );
      }
    }
  }
}

class ApiClient {
  static const String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: 60000,
      baseUrl: "https://newsapi.org/v2",
      queryParameters: {
        "apiKey": apiKey,
      },
    ),
  );
}
