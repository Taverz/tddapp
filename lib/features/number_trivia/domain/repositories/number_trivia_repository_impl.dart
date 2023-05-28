// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:tddapp/core/errore/exceptions.dart';
import 'package:tddapp/core/errore/failures.dart';
import 'package:tddapp/core/errore/network/network_info.dart';

import 'package:tddapp/enitites/number_trivia.dart';
import 'package:tddapp/failure.dart';
import 'package:tddapp/repository.dart';

import '../../data/datasource/number_trivia_local_data_source.dart';
import '../../data/datasource/number_trivia_remote_data_source.dart';

typedef NumberTrivialFailure = Future<Either<FailureApp, NumberTrivial>?>?;

class NumberTrivialRepositoryImpl implements NumberTrivialRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  NumberTrivialRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  NumberTrivialFailure getConcreteNumberTrivia(int? number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  NumberTrivialFailure getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  NumberTrivialFailure _getTrivia(
      Future<NumberTrivial> Function() getConcreteOrRandom) async {
    if (!(await networkInfo.isConnect)) {
      try {
        final resultLocal = await getConcreteOrRandom();
        return Right(resultLocal);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    try {
      final remote = await remoteDataSource.getRandomNumberTrivia();
      localDataSource.cacheNumberTrivia(remote);
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
