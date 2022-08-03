import 'package:dio/dio.dart';

import '../../../../Domain/enities.dart';

import '../../../news_model.dart';

import '../../remote_datas_source.dart';

class AllEntertainmentHeadlines extends ApiClient
    implements IRemoteHeadlineNews {
  @override
  Future<List<HeadLineEntity>> getHeadlineNews(int page) async {
    Response res = await dio.get(
      "/top-headlines",
      queryParameters: {
        "category": "entertainment",
        "country": "ng",
        "pageSize": 7,
        "page": page,
      },
    );

    if (res.statusCode == 200) {
      List<HeadLineEntity> newsList = HeadlineNewsModel.fromList(res.data);
      return newsList;
    } else {
      return throw DioError(requestOptions: res.requestOptions, response: res);
    }
  }
}
