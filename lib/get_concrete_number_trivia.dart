import 'package:dartz/dartz.dart';
import 'package:tddapp/failure.dart';
import 'package:tddapp/repository.dart';

class GetConcreteNumberTrivia {
  final NumberTrivialRepository repository;
  GetConcreteNumberTrivia(this.repository);


  Future<Either<FailureApp, NumberTrivial>> execute({
    required int number,

  })async{
    return await repository.getConcreteNumberTrivia(number);
  }
}