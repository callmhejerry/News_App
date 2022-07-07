import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../api/failure.dart';
import '../../api/news_model.dart';

class RemoteDataSouce extends ApiClient {
  // final String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
  // final String url =
  //     "https://newsapi.org/v2/everything?q=bitcoin&pageSize=10&apiKey=261a68fc65d14243bb91c8d62dc1f557";
  // Dio client = Dio(BaseOptions(
  //   connectTimeout: 60000,
  // ));

  Future<Either<List<News>, Failure>> getBitCoinNews(String pageSize) async {
    try {
      Response res = await dio.get(
        "/everything",
        queryParameters: {
          "q": "bitcoin",
          "pageSize": pageSize,
          "apiKey": apiKey,
        },
      );

      if (res.statusCode == 200) {
        List<News> newsList = News.newsList(res.data);
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
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: 60000,
      baseUrl: "https://newsapi.org/v2",
    ),
  );
  final String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
}
