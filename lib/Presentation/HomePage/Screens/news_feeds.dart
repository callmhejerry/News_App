import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/Presentation/HomePage/Screens/sport_screen.dart';

import 'bitcoin_screen.dart';
import 'business_screen.dart';
import 'entertainment_screen.dart';
import 'politics_screen.dart';

class NewsFeeds extends StatefulWidget {
  const NewsFeeds({Key? key}) : super(key: key);

  @override
  State<NewsFeeds> createState() => _NewsFeedsState();
}

class _NewsFeedsState extends State<NewsFeeds>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  final List<Widget> _tabs = [
    const Text(
      "Politics",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    const Text(
      "Sport",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    const Text(
      "Bitcoin",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    const Text(
      "Entertainment",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    const Text(
      "Business",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          bottom: TabBar(
            tabs: _tabs,
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Colors.black,
            indicatorWeight: 5,
            labelPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          title: Container(
            height: 24.r,
            width: 24.r,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/Logo.png",
                ),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: TabBarView(
          controller: _controller,
          children: const [
            PoliticsFeeds(),
            SportFeeds(),
            BitCoinFeeds(),
            EntertainmentFeeds(),
            BusinessFeeds(),
          ],
        ),
      ),
    );
  }
}
