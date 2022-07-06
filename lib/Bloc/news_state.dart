import 'package:news_app/api/news_model.dart';

import '../api/failure.dart';

enum NewsStatus {
  initial,
  failed,
  loading,
  success,
}

class NewsState {
  final List<News>? news;
  final NewsStatus status;
  final Failure? failure;

  const NewsState({this.news, this.status = NewsStatus.initial, this.failure});

  static NewsState copyWith({List<News>? news, required NewsStatus status}) {
    return NewsState(
      news: news ?? news,
      status: status,
    );
  }
}
