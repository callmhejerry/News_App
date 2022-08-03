import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/news_bloc.dart/news_bloc.dart';
import '../../../logic/news_bloc.dart/news_event.dart';
import '../../../logic/news_bloc.dart/news_state.dart';
import '../../widget/news_feeds_list.dart';

class PoliticsFeeds extends StatelessWidget {
  const PoliticsFeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc<PoliticsFeeds>, NewsState>(
      builder: (context, state) {
        if (state.status == NewsStatus.success) {
          return RefreshIndicator(
            child: NewsFeedList(
              allNewsList: state.news!,
              headlineList: state.headline!,
            ),
            onRefresh: () {
              NewsBloc bloc = context.read<NewsBloc<PoliticsFeeds>>();

              return Future.sync(
                () {
                  bloc.add(ReloadNewsEvent());
                },
              );
            },
          );
        }
        if (state.status == NewsStatus.failed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No internet connection"),
              ElevatedButton(
                onPressed: () {
                  NewsBloc bloc = context.read<NewsBloc<PoliticsFeeds>>();
                  bloc.add(LoadNewsEvent());
                },
                child: const Text("Try again"),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
