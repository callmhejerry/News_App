import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/news_event.dart';
import 'package:news_app/Bloc/news_state.dart';
import 'package:news_app/api/news_api.dart';

import '../api/failure.dart';
import '../api/news_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsApi newsApi;
  NewsBloc({required this.newsApi}) : super(const NewsState(news: null)) {
    on<LoadNewsEvent>(_load);
  }

  _load(event, emit) async {
    if (state.status == NewsStatus.initial) {
      emit(const NewsState(status: NewsStatus.loading, news: []));
      Either<List<News>, Failure> newsList = await newsApi.getNews("15");
      newsList.fold((newsList) {
        emit(NewsState(news: newsList, status: NewsStatus.success));
      }, (failure) {
        emit(NewsState(news: [], status: NewsStatus.failed, failure: failure));
      });
    } else {
      Either<List<News>, Failure> newsList = await newsApi.getNews("15");
      newsList.fold((newsList) {
        emit(NewsState.copyWith(
          status: NewsStatus.success,
          news: List.of(state.news!)..addAll(newsList),
        ));
      }, (failure) {
        emit(NewsState(news: [], status: NewsStatus.failed, failure: failure));
      });
    }
  }
}
