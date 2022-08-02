import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Data/DataSources/local_data_source.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Data/news_repo.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/logic/internet_bloc/internet_bloc.dart';

import 'package:news_app/utils/internet_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'Data/DataSources/AllNews/bitcoin_news.dart';
import 'Presentation/HomePage/home_page.dart';

import 'logic/news_bloc.dart/news_bloc.dart';
import 'logic/news_bloc.dart/news_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NewsEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) {
            return NewsBloc<BitCoinPage>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllBitCoinNews(),
                  remoteHeadlineNews: AllBitCoinHeadlines(),
                ),
                newsLocalDataSource: LocalDataSource(),
                internetConnection: InternetConnection(),
              ),
            )..add(LoadNewsEvent());
          }),
        ),
        BlocProvider(
          create: (context) => InternetBloc(
            internetConnection: InternetConnection(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return const MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: NewsFeeds(),
          );
        },
        designSize: const Size(375, 812),
      ),
    );
  }
}

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
      "Finance",
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
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
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w),
              sliver: const SliverToBoxAdapter(
                child: Title(title: "Headlines"),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 366.h,
                child: ListView(
                  padding: EdgeInsets.only(left: 16.w),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HeadlineCard(),
                    HeadlineCard(),
                    HeadlineCard(),
                    HeadlineCard(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w),
              sliver: const SliverToBoxAdapter(
                child: Title(title: "Trending"),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverFixedExtentList(
                delegate: SliverChildListDelegate(
                  [
                    const TreandingCard(),
                    const TreandingCard(),
                    const TreandingCard(),
                  ],
                ),
                itemExtent: 130.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TreandingCard extends StatelessWidget {
  const TreandingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150.h,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13.r),
            child: Image.asset(
              "assets/Mask.png",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              // height: 100.r,
              // width: 100.r,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Wendy global same store sales steadily",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.27,
                    letterSpacing: 0.21.w,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Convictons are getting seriously out of hand right now",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: const Color(0xff3c3c43).withOpacity(0.60),
                    fontSize: 12.sp,
                    height: 1.33,
                    letterSpacing: -0.24.w,
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

class Title extends StatelessWidget {
  final String title;
  const Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 12.h),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }
}

class HeadlineCard extends StatelessWidget {
  const HeadlineCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14.w),
      child: SizedBox(
        width: 250.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/Mask.png",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: 24.h, left: 16.w, right: 16.w, top: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FOR YOU",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.08.w,
                              height: 1.38,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Wendy's global same store sales steadily",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.27,
                              letterSpacing: 0.35.w,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Convictions horror justice predujice chaos aversion morality play right virtue",
                            style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.3,
                              // letterSpacing: -0.32.w,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
