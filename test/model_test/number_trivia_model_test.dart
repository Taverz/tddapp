import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
import 'package:tddapp/enitites/number_trivia.dart';

import '../fixtures/fixtures_redear.dart';

void main() {
  final tNumberTriviaModel = NumberTrivialModel(number: 1, text: 'le+40 is the Eddington—Dirac number.');

  test(
    'tset 1 1',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivial>());
    },
  );

  group('Group test 1 ==  NumberTrivialModel', () {

    test(
        'should return a valid model when the JSON number is an integer',
        () async {
          // assert
          final Map<String, dynamic> jsonMapw = json.decode(fixture('trivia.json'));
          //act
          final result = NumberTrivialModel.fromJsonMap(jsonMapw);
          //assert
          expect(result, tNumberTriviaModel);
        },
    );
    test(
        'should return a valid model when the JSON number is an double',
        () async {
          // assert
          final Map<String, dynamic> jsonMapw = json.decode(fixture('trivia_double.json'));
          //act
          final result = NumberTrivialModel.fromJsonMap(jsonMapw);
          //assert
          expect(result, tNumberTriviaModel);
        },
    );
    },
  );

  group('toJson', 
  () { 
      test(
          'should return a JSON map containing the proper data',
          () async {
            // act
            final toJsonMethod = tNumberTriviaModel.toMap();
            //assert
            final Map<String, Object> expectedMap  = {
                  'text':'le+40 is the Eddington—Dirac number.',
                  'number': 1,
                  // "found" :true,
                  // "type": "trivia"
              };
            expect(
              toJsonMethod, 
              expectedMap,
            );
          },
      );
    },
  );
}



