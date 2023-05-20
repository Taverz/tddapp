import 'package:dartz/dartz.dart';
import 'package:tddapp/failure.dart';

import 'enitites/number_trivia.dart';

abstract class NumberTrivialRepository {
  Future<Either<FailureApp, NumberTrivial>> getConcreteNumberTrivia(int? number);
  Future<Either<FailureApp, NumberTrivial>> getRandomNumberTrivia();
}
