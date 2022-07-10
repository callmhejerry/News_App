import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Data/DataSources/local_data_source.dart';
import 'package:news_app/Data/DataSources/remote_datas_source.dart';
import 'package:news_app/Data/news_repo.dart';
import 'package:news_app/Domain/enities.dart';
import 'package:news_app/Presentation/HomePage/news_bloc.dart';
import 'package:news_app/utils/internet_checker.dart';
import 'package:path_provider/path_provider.dart';

import 'Presentation/HomePage/home_page.dart';
import 'Presentation/HomePage/news_event.dart';

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
    return BlocProvider<NewsBloc>(
      create: (context) => NewsBloc(
        newsRepo: NewsRepo(
          newsRemoteDataSource: RemoteDataSouce(),
          newsLocalDataSource: LocalDataSource(),
          internetConnection: InternetConnection(),
        ),
      )..add(LoadNewsEvent()),
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: NewsApp(),
      ),
    );
  }
}
