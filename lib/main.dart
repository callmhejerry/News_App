import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Bloc/news_bloc.dart';
import 'package:news_app/Bloc/news_event.dart';
import 'package:news_app/Bloc/news_state.dart';
import 'package:news_app/api/news_api.dart';

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
          if (state.status == NewsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == NewsStatus.success) {
            return const NewsList();
          }
          return const Center(
            child: Text("an error occured"),
          );
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: const [
        NewsPost(),
        SizedBox(
          height: 20,
        ),
        NewsPost(),
      ],
    );
  }
}

class NewsPost extends StatelessWidget {
  const NewsPost({Key? key}) : super(key: key);

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
          Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.deepOrange,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: const [
                Text(
                  "The least imaginative holiday gift everyone will bw getting is a christmas toy",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "These is the following news from the ofice of the chairman of asuu , saying the strike will be called of oon, that student hould be patience",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 2,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Chinedu",
                    style: TextStyle(
                      fontSize: 15,
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
