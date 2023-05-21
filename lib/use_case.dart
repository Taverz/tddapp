

import 'package:dartz/dartz.dart';
import 'package:tddapp/failure.dart';

abstract class UseCase<Type, Params>{
  Future<Either<FailureApp, Type>> call(Params params);
}