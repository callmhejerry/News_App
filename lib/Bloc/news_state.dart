import 'package:news_app/Domain/enities.dart';

import '../api/failure.dart';

enum NewsStatus {
  initial,
  failed,
  loading,
  success,
}

class NewsState {
  final List<NewsEntity>? news;
  final NewsStatus status;
  final Failure? failure;

  const NewsState({this.news, this.status = NewsStatus.initial, this.failure});

  static NewsState copyWith(
      {List<NewsEntity>? news, required NewsStatus status}) {
    return NewsState(
      news: news ?? news,
      status: status,
    );
  }
}
