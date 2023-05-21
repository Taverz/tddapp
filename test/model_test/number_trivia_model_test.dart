import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
import 'package:tddapp/enitites/number_trivia.dart';

import '../fixtures/fixtures_redear.dart';

void main() {
  final tNumberTriviaModel = NumberTrivialModel(number: 1, text: '');

  test(
    'sasd',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivial>());
    },
  );

  group('', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // assert
        final Map<String, dynamic> jsonMapw = json.decode(fixture('trivia.json'));

        //act
        // final result = NumberTrivialModel.
      },
    );
  });
}
