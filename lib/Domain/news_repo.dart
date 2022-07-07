import 'package:dartz/dartz.dart';

import '../api/failure.dart';
import '../api/news_model.dart';

abstract class INewsRepo {
  Future<Either<List<News>, Failure>> getBitCoinNews(String newsCount);
}
