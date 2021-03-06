import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/Data/news_repo.dart';
import 'package:news_app/Domain/enities.dart';
import '../../utils/failure.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepo newsRepo;
  NewsBloc({required this.newsRepo}) : super(const NewsState(news: null)) {
    on<LoadNewsEvent>(_load);
  }

  _load(event, emit) async {
    if (state.status == NewsStatus.initial) {
      emit(const NewsState(status: NewsStatus.loading, news: []));
      Either<List<NewsEntity>, Failure> newsList =
          await newsRepo.getBitCoinNews("15");
      newsList.fold((newsList) {
        emit(NewsState(news: newsList, status: NewsStatus.success));
      }, (failure) {
        emit(NewsState(news: [], status: NewsStatus.failed, failure: failure));
      });
    } else {
      Either<List<NewsEntity>, Failure> newsList =
          await newsRepo.getBitCoinNews("15");
      newsList.fold((newsList) {
        emit(
          NewsState.copyWith(
            status: NewsStatus.success,
            news: List.of(state.news!)..addAll(newsList),
          ),
        );
      }, (failure) {
        emit(NewsState(news: [], status: NewsStatus.failed, failure: failure));
      });
    }
  }
}
