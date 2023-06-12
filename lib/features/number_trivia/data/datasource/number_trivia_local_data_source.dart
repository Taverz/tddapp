import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddapp/core/errore/exceptions.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
// import 'package:meta/meta';

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

const CHACHED_NUMBER_TRIVIA = 'CHACHED_NUMBER_TRIVIA';

class NumberTrivialLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPrefereces;

  NumberTrivialLocalDataSourceImpl({required this.sharedPrefereces});

  @override
  Future<bool> cacheNumberTrivia(NumberTrivialModel triviaToCache) async {
   final jsonString =await  sharedPrefereces.setString(CHACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
    if (jsonString == true) {
      return true;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<NumberTrivialModel> getLastnumbertrivia() async {
    final jsonString = sharedPrefereces.getString(CHACHED_NUMBER_TRIVIA);
    if (jsonString == null) {
      return Future.value(
        NumberTrivialModel.fromJson(
          json.decode(jsonString ?? ""),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
