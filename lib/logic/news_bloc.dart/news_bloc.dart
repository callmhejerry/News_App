import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/Data/news_repo.dart';
import 'package:news_app/Domain/enities.dart';
import '../../utils/failure.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc<T> extends Bloc<NewsEvent, NewsState> {
  NewsRepo newsRepo;
  late bool loaded;
  int newsCount = 1;
  NewsBloc({required this.newsRepo}) : super(const NewsState(news: null)) {
    on<LoadNewsEvent>(_load);
    on<ReloadNewsEvent>(
      (event, emit) {
        emit(const NewsState(status: NewsStatus.initial));
        add(LoadNewsEvent());
      },
    );
  }

  _load(event, emit) async {
    late List<NewsEntity> allNewsResult;
    late List<HeadLineEntity> headlineResult;
    if (state.status == NewsStatus.initial ||
        state.status == NewsStatus.failed) {
      emit(
        const NewsState(
          status: NewsStatus.loading,
          news: [],
          headline: [],
        ),
      );
      var result = await Future.wait(
        [newsRepo.getHeadlineNews(newsCount), newsRepo.getAllNews(newsCount)],
      );
      Either<List<HeadLineEntity>, Failure> headline =
          result[0] as Either<List<HeadLineEntity>, Failure>;
      Either<List<NewsEntity>, Failure> allNews =
          result[1] as Either<List<NewsEntity>, Failure>;

      allNews.fold((left) {
        allNewsResult = left;
      }, (r) {
        allNewsResult = [];
      });
      headline.fold((left) {
        headlineResult = left;
      }, (r) {
        headlineResult = [];
      });

      if (headlineResult.isEmpty && allNewsResult.isEmpty) {
        emit(
          NewsState(
            headline: headlineResult,
            status: NewsStatus.failed,
            news: allNewsResult,
          ),
        );
      } else {
        emit(
          NewsState(
            headline: headlineResult,
            status: NewsStatus.success,
            news: allNewsResult,
          ),
        );
      }

      // Either<List<NewsEntity>, Failure> newsList =
      //     await newsRepo.getAllNews(15);
      // newsList.fold((newsList) {
      //   emit(
      //     NewsState(news: newsList, status: NewsStatus.success),
      //   );
      //   loaded = true;
      // }, (failure) {
      //   emit(
      //     NewsState(news: [], status: NewsStatus.failed, failure: failure),
      //   );
      // });
    } else {
      Either<List<NewsEntity>, Failure> newsList =
          await newsRepo.getAllNews(newsCount);
      newsList.fold(
        (newsList) {
          emit(
            NewsState.copyWith(
              status: NewsStatus.success,
              news: List.of(state.news!)..addAll(newsList),
            ),
          );
        },
        (failure) {
          emit(
            NewsState(
              news: [],
              status: NewsStatus.failed,
              failure: failure,
            ),
          );
        },
      );
    }
  }
}
