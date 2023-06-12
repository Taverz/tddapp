import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tddapp/core/errore/exceptions.dart';

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

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<NumberTrivialModel> getConcreteNumberTrivia(int? number) async {
    final x = await client.get(
      Uri.parse('http://numbersapi.com/$number'),
      headers: {'Content-Type': 'application/json'},
    );
    if (x.statusCode == 200) {
      return NumberTrivialModel.fromJson(json.decode(x.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<NumberTrivialModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
