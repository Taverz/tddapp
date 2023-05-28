


import 'package:tddapp/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the https://api.com/{number} endpoint
  /// 
  /// Throws a [ServerException] for all errore codes.
  Future<NumberTrivialModel> getConcreteNumberTrivia(int? number);
  
  /// Calls the https://api.com/random endpoint
  /// 
  /// Throws a [ServerException] for all errore codes.
  Future<NumberTrivialModel> getRandomNumberTrivia();
}