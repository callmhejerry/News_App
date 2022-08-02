import 'package:dio/dio.dart';
import 'package:news_app/Domain/enities.dart';

class RemoteDataSouce {
  RemoteDataSouce({
    required this.remoteHeadlineNews,
    required this.remoteAllNews,
  });
  late IRemoteHeadlineNews remoteHeadlineNews;
  late IRemoteAllNews remoteAllNews;
  Future<List<NewsEntity>> getAllNews(int pageSize) async {
    return remoteAllNews.getAllNews(pageSize);
  }

  getHeadlineNews(int page) {
    return remoteHeadlineNews.getHeadlineNews(page);
  }
}

abstract class IRemoteHeadlineNews {
  getHeadlineNews(int page);
}

abstract class IRemoteAllNews {
  Future<List<NewsEntity>> getAllNews(int page);
}

class AllBitCoinHeadlines implements IRemoteHeadlineNews {
  @override
  getHeadlineNews(int page) {}
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

// abstract class IApiClient {
//   static const String apiKey = "261a68fc65d14243bb91c8d62dc1f557";
//   Dio dio();
// }

// class AllApiClient implements IApiClient {
//   @override
//   dio() {
//     return Dio(
//       BaseOptions(
//         connectTimeout: 10000,
//         baseUrl: "https://newsapi.org/v2",
//         queryParameters: {
//           "apiKey": IApiClient.apiKey,
//         },
//       ),
//     );
//   }
// }
