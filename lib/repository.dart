import 'package:dartz/dartz.dart';
import 'package:tddapp/failure.dart';

abstract class NumberTrivialRepository {
  Future<Either<FailureApp, NumberTrivial>> getConcreteNumberTrivia(int number);
  Future<Either<FailureApp, NumberTrivial>> getRandomNumberTrivia();
}

class NumberTrivial {}