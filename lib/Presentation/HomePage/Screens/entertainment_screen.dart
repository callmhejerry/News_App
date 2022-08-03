import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/news_bloc.dart/news_bloc.dart';
import '../../../logic/news_bloc.dart/news_event.dart';
import '../../../logic/news_bloc.dart/news_state.dart';
import '../../widget/news_feeds_list.dart';

class EntertainmentFeeds extends StatelessWidget {
  const EntertainmentFeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc<EntertainmentFeeds>, NewsState>(
      builder: (context, state) {
        if (state.status == NewsStatus.success) {
          return RefreshIndicator(
            child: NewsFeedList(
              allNewsList: state.news!,
              headlineList: state.headline!,
            ),
            onRefresh: () {
              NewsBloc bloc = context.read<NewsBloc<EntertainmentFeeds>>();

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
                  NewsBloc bloc = context.read<NewsBloc<EntertainmentFeeds>>();
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
