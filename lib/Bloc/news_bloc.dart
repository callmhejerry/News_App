import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/news_event.dart';
import 'package:news_app/Bloc/news_state.dart';
import 'package:news_app/api/news_api.dart';

import '../api/news_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsApi newsApi;
  NewsBloc({required this.newsApi}) : super(const NewsState(news: null)) {
    on<LoadNewsEvent>(_load);
  }

  _load(event, emit) async {
    if (state.status == NewsStatus.loading) {
      List<News>? newsList = await newsApi.getNews("10");
      if (newsList != null) {
        emit(NewsState(news: newsList, status: NewsStatus.success));
      } else {
        emit(const NewsState(news: null, status: NewsStatus.failed));
      }
    } else {
      List<News>? newsList = await newsApi.getNews("15");
      if (newsList != null) {
        emit(NewsState.copyWith(
          status: NewsStatus.success,
          news: List.of(state.news!)..addAll(newsList),
        ));
      }
    }
  }
}
