


import 'package:tddapp/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] wich was gotten the last time the user had an internet connect.
  /// 
  /// Throws [NoLocalDataException] / [CacheException] if no cached data is present.
  Future<NumberTrivialModel> getLastnumbertrivia();
  
  /// Calls the
  /// 
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<void> cacheNumberTrivia(NumberTrivialModel numberTrivialModel);
}