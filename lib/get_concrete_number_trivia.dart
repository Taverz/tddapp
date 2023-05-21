import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tddapp/failure.dart';
import 'package:tddapp/repository.dart';
import 'package:tddapp/use_case.dart';

import 'enitites/number_trivia.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivial, ParamsW> {
  final NumberTrivialRepository repository;
  GetConcreteNumberTrivia(this.repository);


  // Future<Either<FailureApp, NumberTrivial>> execute({
  //   required int number,

  // })async{
  //   return await repository.getConcreteNumberTrivia(number);
  // }

  @override
  Future<Either<FailureApp, NumberTrivial>> call(ParamsW params)async{
    return Right(NumberTrivial(number: 1, text: 'test'));
  }


}

class ParamsW extends Equatable {
  final int number;
  ParamsW({required this.number})
  // : super([number])
  ;
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}