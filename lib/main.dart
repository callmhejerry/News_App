import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Data/DataSources/LocalDatasource/local_bitcoi.dart';
import 'package:news_app/Data/DataSources/RemoteDataSource/AllNews/politics_news.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Data/news_repo.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/logic/internet_bloc/internet_bloc.dart';

import 'package:news_app/utils/internet_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'Data/DataSources/LocalDatasource/local_business.dart';
import 'Data/DataSources/LocalDatasource/local_entertainment.dart';
import 'Data/DataSources/LocalDatasource/local_politics.dart';
import 'Data/DataSources/LocalDatasource/local_sport.dart';
import 'Data/DataSources/RemoteDataSource/AllNews/bitcoin_news.dart';
import 'Data/DataSources/RemoteDataSource/AllNews/business_news.dart';
import 'Data/DataSources/RemoteDataSource/AllNews/entertainment_news.dart';
import 'Data/DataSources/RemoteDataSource/AllNews/sport_news.dart';
import 'Data/DataSources/RemoteDataSource/HeaddlineNews/bitcoin_headline.dart';
import 'Data/DataSources/RemoteDataSource/HeaddlineNews/business.dart';
import 'Data/DataSources/RemoteDataSource/HeaddlineNews/entertainment.dart';
import 'Data/DataSources/RemoteDataSource/HeaddlineNews/politics_headline.dart';

import 'Data/DataSources/RemoteDataSource/HeaddlineNews/sport.dart';
import 'Presentation/HomePage/Screens/bitcoin_screen.dart';
import 'Presentation/HomePage/Screens/business_screen.dart';
import 'Presentation/HomePage/Screens/entertainment_screen.dart';
import 'Presentation/HomePage/Screens/news_feeds.dart';
import 'Presentation/HomePage/Screens/politics_screen.dart';
import 'Presentation/HomePage/Screens/sport_screen.dart';
import 'logic/news_bloc.dart/news_bloc.dart';
import 'logic/news_bloc.dart/news_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(NewsEntityAdapter());
  Hive.registerAdapter(HeadLineEntityAdapter());
  await Hive.openBox<HeadLineEntity>("headline-Politics");
  await Hive.openBox<HeadLineEntity>("headline-Sport");
  await Hive.openBox<HeadLineEntity>("headline-Bitcoin");
  await Hive.openBox<HeadLineEntity>("headline-Entertainment");
  await Hive.openBox<HeadLineEntity>("headline-Business");
  await Hive.openBox<NewsEntity>("Politics-news");
  await Hive.openBox<NewsEntity>("Sport-news");
  await Hive.openBox<NewsEntity>("Bitcoin-news");
  await Hive.openBox<NewsEntity>("Entertainment-news");
  await Hive.openBox<NewsEntity>("Business-news");
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
            return NewsBloc<BitCoinFeeds>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllBitCoinNews(),
                  remoteHeadlineNews: AllBitCoinHeadlines(),
                ),
                newsLocalDataSource: BitcoinLocalDataSource(),
                internetConnection: InternetConnection(),
              ),
            )..add(LoadNewsEvent());
          }),
        ),
        BlocProvider(
          create: ((context) {
            return NewsBloc<PoliticsFeeds>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllPoliticsNews(),
                  remoteHeadlineNews: AllPoliticsHeadlines(),
                ),
                newsLocalDataSource: PoliticsLocalDataSource(),
                internetConnection: InternetConnection(),
              ),
            )..add(LoadNewsEvent());
          }),
        ),
        BlocProvider(
          create: ((context) {
            return NewsBloc<BusinessFeeds>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllBusinessNews(),
                  remoteHeadlineNews: AllBusinessHeadlines(),
                ),
                newsLocalDataSource: BusinessLocalDataSource(),
                internetConnection: InternetConnection(),
              ),
            )..add(LoadNewsEvent());
          }),
        ),
        BlocProvider(
          create: ((context) {
            return NewsBloc<SportFeeds>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllSportNews(),
                  remoteHeadlineNews: AllSportHeadlines(),
                ),
                newsLocalDataSource: SportLocalDataSource(),
                internetConnection: InternetConnection(),
              ),
            )..add(LoadNewsEvent());
          }),
        ),
        BlocProvider(
          create: ((context) {
            return NewsBloc<EntertainmentFeeds>(
              newsRepo: NewsRepo(
                newsRemoteDataSource: RemoteDataSouce(
                  remoteAllNews: AllEntertainmentNews(),
                  remoteHeadlineNews: AllEntertainmentHeadlines(),
                ),
                newsLocalDataSource: EntertainmentLocalDataSource(),
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
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Rubik",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const NewsFeeds(),
          );
        },
        designSize: const Size(375, 812),
      ),
    );
  }
}
