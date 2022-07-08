import 'package:dartz/dartz.dart';
import 'package:news_app/Domain/enities.dart';

import '../api/failure.dart';

abstract class INewsRepo {
  Future<Either<List<NewsEntity>, Failure>> getBitCoinNews(String newsCount);
}
