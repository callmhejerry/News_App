import 'package:dartz/dartz.dart';

import '../api/failure.dart';

abstract class UseCase<T, String> {
  Future<Either<T, Failure>> getNews(String newsCount);
}
