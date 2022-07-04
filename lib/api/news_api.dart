import 'package:dio/dio.dart';

import 'news_model.dart';

class NewsApi {
  final String url =
      "https://newsapi.org/v2/everything?q=bitcoin&pageSize=10&apiKey=261a68fc65d14243bb91c8d62dc1f557";
  Dio client = Dio();
  Future<List<News>?> getNews(String pageSize) async {
    try {
      Response res = await client.get(
          "https://newsapi.org/v2/everything?q=bitcoin&pageSize=$pageSize&apiKey=261a68fc65d14243bb91c8d62dc1f557");

      if (res.statusCode == 200) {
        List<News> newsList = News.newsList(res.data["articles"]);
        return newsList;
      }
      return null;
    } on DioError {
      return null;
    }
  }
}
