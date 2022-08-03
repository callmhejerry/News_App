import 'package:dio/dio.dart';

import '../../../../Domain/enities.dart';
import '../../../news_model.dart';
import '../../remote_datas_source.dart';

class AllEntertainmentNews extends ApiClient implements IRemoteAllNews {
  @override
  Future<List<NewsEntity>> getAllNews(int page) async {
    Response res = await dio.get(
      "/everything",
      queryParameters: {
        "q": "entertainment",
        "pageSize": 10,
        "page": page,
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
