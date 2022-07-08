import 'package:dio/dio.dart';
import 'package:news_app/Domain/enities.dart';

import '../../api/news_model.dart';

class RemoteDataSouce extends ApiClient {
  Future<List<NewsEntity>> getBitCoinNews(String pageSize) async {
    Response res = await dio.get(
      "/everything",
      queryParameters: {
        "q": "bitcoin",
        "pageSize": pageSize,
      },
    );

    if (res.statusCode == 200) {
      List<NewsEntity> newsList = News.newsList(res.data);
      return newsList;
    }
    throw ServerException();
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

class ServerException implements Exception {}
