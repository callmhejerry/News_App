import 'package:dartz/dartz.dart';
import 'package:news_app/Domain/enities.dart';

import '../utils/failure.dart';

abstract class INewsRepo {
  Future<Either<List<NewsEntity>, Failure>> getAllNews(int newsCount);
  getHeadlineNews(int newCount);
}
