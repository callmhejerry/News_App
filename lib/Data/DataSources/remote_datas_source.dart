import 'package:dio/dio.dart';
import 'package:news_app/Domain/enities.dart';

import '../news_model.dart';

class RemoteDataSouce {
  RemoteDataSouce({
    required this.remoteHeadlineNews,
    required this.remoteAllNews,
  });
  late IRemoteHeadlineNews remoteHeadlineNews;
  late IRemoteAllNews remoteAllNews;
  Future<List<NewsEntity>> getAllNews(String pageSize) async {
    return remoteAllNews.getAllNews(pageSize);
  }
}

abstract class IRemoteHeadlineNews {
  getHeadlineNews();
}

abstract class IRemoteAllNews {
  Future<List<NewsEntity>> getAllNews(String pageSize);
}

class AllBitCoinNews extends ApiClient implements IRemoteAllNews {
  @override
  Future<List<NewsEntity>> getAllNews(String pageSize) async {
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
    } else {
      return throw DioError(requestOptions: res.requestOptions, response: res);
    }
  }
}

class AllBitCoinHeadlines implements IRemoteHeadlineNews {
  @override
  getHeadlineNews() {}
}

class ApiClient {
  static const String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: 10000,
      baseUrl: "https://newsapi.org/v2",
      queryParameters: {
        "apiKey": apiKey,
      },
    ),
  );
}

abstract class IApiClient {
  static const String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
  Dio dio();
}

class AllApiClient implements IApiClient {
  @override
  dio() {
    return Dio(
      BaseOptions(
        connectTimeout: 10000,
        baseUrl: "https://newsapi.org/v2",
        queryParameters: {
          "apiKey": IApiClient.apiKey,
        },
      ),
    );
  }
}
