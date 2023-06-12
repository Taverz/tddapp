import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tddapp/core/errore/exceptions.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
import 'package:tddapp/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';

import '../../../../fixtures/fixtures_redear.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl remoteDataSource;
  late MockHttpClient mockHttpClient;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      remoteDataSource =
          NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
    },
  );

  group(
    '',
    () {
      final tNumber = 1;
      final tNumberTriviaModel =
          NumberTrivialModel.fromJson(json.decode(fixture('trivia.json')));
      test(
        'should peerform a GET request on a URL with number begin the endpoint and with application/json header',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse(any ?? ""),
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
          remoteDataSource.getConcreteNumberTrivia(tNumber);
          verify(
            mockHttpClient.get(
              Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'},
            ),
          );
        },
      );

      test(
        'shuold return NUmberTrivia when the response code is 200 (success)',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse(any ?? ""),
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
          final result =
              await remoteDataSource.getConcreteNumberTrivia(tNumber);
          expect(result, equals(tNumberTriviaModel));
        },
      );

      test(
        'shuold return NUmberTrivia when the response code is 200 (success)',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse(any ?? ""),
              headers: anyNamed('headers'),
            ),
          ).thenAnswer((_) async => http.Response('Something wrnt wrong', 404));
          final call = remoteDataSource.getConcreteNumberTrivia;
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
