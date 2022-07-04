import 'package:news_app/api/news_model.dart';

enum NewsStatus {
  loading,
  failed,
  success,
}

class NewsState {
  final List<News>? news;
  final NewsStatus status;

  const NewsState({this.news, this.status = NewsStatus.loading});

  static NewsState copyWith({List<News>? news, required NewsStatus status}) {
    return NewsState(
      news: news ?? news,
      status: status,
    );
  }
}
