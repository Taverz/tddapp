import 'package:dartz/dartz.dart';
import 'package:tddapp/failure.dart';

import 'enitites/number_trivia.dart';

typedef NumberTrivialFailure = Future<Either<FailureApp, NumberTrivial>?>? ; //Future<(FailureApp? , NumberTrivial?)?>? ;
abstract class NumberTrivialRepository {
  NumberTrivialFailure getConcreteNumberTrivia(int? number){
    throw UnimplementedError('getConcreteNumberTrivia() has not been implemented.');
  }
  NumberTrivialFailure getRandomNumberTrivia(){
    throw UnimplementedError('getRandomNumberTrivia() has not been implemented.');
  }
}
