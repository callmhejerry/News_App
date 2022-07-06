import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/news_bloc.dart';
import 'package:news_app/Bloc/news_event.dart';
import 'package:news_app/Bloc/news_state.dart';
import 'package:news_app/api/news_api.dart';

import 'api/news_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsApi: NewsApi())..add(LoadNewsEvent()),
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: NewsApp(),
      ),
    );
  }
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "News",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            label: "Saved",
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          // print(state.status);
          if (state.status == NewsStatus.success) {
            print(state.status);
            return NewsList(
              newsList: state.news!,
            );
          }
          if (state.status == NewsStatus.failed) {
            print(state.status);
            return Center(
              child: Text(state.failure!.message),
            );
          }
          print(state.status);
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<News> newsList;
  const NewsList({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        return NewsPost(
          author: newsList[index].author,
          description: newsList[index].description,
          imageUrl: newsList[index].imageUrl,
          title: newsList[index].title,
        );
      },
      itemCount: newsList.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}

class NewsPost extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String description;
  const NewsPost({
    Key? key,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-1, -1),
            blurRadius: 5,
          ),
          BoxShadow(
            offset: Offset(1, -1),
            color: Colors.grey,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            errorWidget: (context, url, error) {
              return const Center(
                child: Text("Image failed loading"),
              );
            },
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            // fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            fadeInDuration: const Duration(seconds: 1),
            alignment: Alignment.center,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "~$author",
                    style: const TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
