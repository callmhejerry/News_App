import 'package:news_app/Domain/enities.dart';

import '../../utils/failure.dart';

enum NewsStatus {
  initial,
  failed,
  loading,
  success,
}

class NewsState {
  final List<NewsEntity>? news;
  final List<HeadLineEntity>? headline;
  final NewsStatus status;
  final Failure? failure;

  const NewsState(
      {this.news,
      this.status = NewsStatus.initial,
      this.failure,
      this.headline});

  static NewsState copyWith(
      {List<NewsEntity>? news,
      required NewsStatus status,
      List<HeadLineEntity>? headline}) {
    return NewsState(
      news: news ?? news,
      status: status,
      headline: headline ?? headline,
    );
  }
}
