import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddapp/core/errore/exceptions.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
import 'package:tddapp/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixtures_redear.dart';

class MockSharedPrederences extends Mock implements SharedPreferences {}

void main() {
  late NumberTrivialLocalDataSourceImpl dataSource;
  late MockSharedPrederences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPrederences();
    dataSource = NumberTrivialLocalDataSourceImpl(
        sharedPrefereces: mockSharedPreferences);
  });

  group(
    'getListNumberTrivia',
    () {
      final tNumbertrivialModel = NumberTrivialModel.fromJson(
          json.decode(fixture('trivia_cached.json')));
      test(
        'should return NumbeerTrivia',
        () async {
          when(mockSharedPreferences.getString(any ?? ""))
              .thenReturn(fixture('trivia_cached.json'));
          final result = await dataSource.getLastnumbertrivia();
          verify(mockSharedPreferences.getString(CHACHED_NUMBER_TRIVIA));
          expect(result, equals(tNumbertrivialModel));
        },
      );

      test(
        'should throw a CachedException when there is not a cached value',
        () async {
          when(mockSharedPreferences.getString(any ?? "")).thenReturn(null);
          final call = dataSource.getLastnumbertrivia;

          // verify(mockSharedPreferences.getString(CHACHED_NUMBER_TRIVIA));
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    'cacheNumberTrivia',
    () {
      final tNumberTriviaModel =
          NumberTrivialModel(text: 'test trivia', number: 1);
      test(
        'should throw a SharedPrefer to cached the data',
        () async {
          dataSource.cacheNumberTrivia(tNumberTriviaModel);
          final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
          verify(mockSharedPreferences.setString(CHACHED_NUMBER_TRIVIA, expectedJsonString));
        },
      );
    },
  );
}
