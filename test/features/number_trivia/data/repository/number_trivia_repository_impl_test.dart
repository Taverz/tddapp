import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/core/errore/exceptions.dart';
import 'package:tddapp/core/errore/network/network_info.dart';
import 'package:tddapp/data/models/number_trivia_model.dart';
import 'package:tddapp/enitites/number_trivia.dart';
import 'package:tddapp/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:tddapp/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:tddapp/features/number_trivia/domain/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTrivialRepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTrivialRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnect).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnect).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group(
    'getConcreteNumberTrivia',
    () async {
      final tNumber = 1;
      final tNumberTriviaModel =
          NumberTrivialModel(text: 'test Trivia', number: tNumber);
      final NumberTrivial tnumberTrivia = tNumberTriviaModel;

      test(
        'should check if the device is online',
        () async {
          ///arrange
          when(mockNetworkInfo.isConnect)
              .thenAnswer((realInvocation) async => true);

          /// act
          repositoryImpl.getConcreteNumberTrivia(tNumber);

          /// assert
          verify(mockNetworkInfo.isConnect);
        },
      );

      runTestOnline( () {
          // 2.29.49
          // setUp(() {
          //   when(mockNetworkInfo.isConnect)
          //       .thenAnswer((realInvocation) async => true);
          // });
          test(
            'should return remote data when the call to remote data source is successful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                  .thenAnswer((_) async => tNumberTriviaModel);

              /// act
              final result =
                  await repositoryImpl.getConcreteNumberTrivia(tNumber);

              /// assert
              verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
              expect(result, equals(Right(tnumberTrivia)));
            },
          );
          test(
            'should return server failure when the call to remote data source is unsuccessful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                  .thenThrow(ServerException());

              /// act
              final result =
                  await repositoryImpl.getConcreteNumberTrivia(tNumber);

              /// assert
              verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
              verifyZeroInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerException)));
            },
          );

          test(
            'should return local data when the call to remote data source is unsuccessful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                  .thenAnswer((_) async => tNumberTriviaModel);

              /// act
              await repositoryImpl.getConcreteNumberTrivia(tNumber);

              /// assert
              verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
              verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
              // expect(result, equals(Right(tnumberTrivia)));
              // expect(result, equals(Left(ServerException)));
            },
          );
        },
      );

      runTestOffline( () {
        // setUp(() {
        //   when(mockNetworkInfo.isConnect).thenAnswer((_) async => false);
        // });
        test(
          'should  return last locally cached data when the cached data is present.',
          () async {
            // arrange
            when(mockLocalDataSource.getLastnumbertrivia())
                .thenAnswer((_) async => tNumberTriviaModel);

            ///act
            final result =
                await repositoryImpl.getConcreteNumberTrivia(tNumber);

            ///assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastnumbertrivia());
            expect(result, equals(Right(tnumberTrivia)));
          },
        );
        test(
          'should return cache failure when there is no cached data present.',
          () async {
            // arrange
            when(mockLocalDataSource.getLastnumbertrivia())
                .thenThrow(CacheException());

            ///act
            final result =
                await repositoryImpl.getConcreteNumberTrivia(tNumber);

            ///assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastnumbertrivia());
            expect(result, equals(Left(CacheException())));
          },
        );
      });
    },
  );


   group(
    'getRandomNumberTrivia',
    () async {
      final tNumber =123;
      final tNumberTriviaModel =
          NumberTrivialModel(text: 'test Trivia', number: tNumber);
      final NumberTrivial tnumberTrivia = tNumberTriviaModel;

      test(
        'should check if the device is online',
        () async {
          ///arrange
          when(mockNetworkInfo.isConnect)
              .thenAnswer((realInvocation) async => true);

          /// act
          repositoryImpl.getRandomNumberTrivia();

          /// assert
          verify(mockNetworkInfo.isConnect);
        },
      );

      runTestOnline( () {
          // 2.29.49
          // setUp(() {
          //   when(mockNetworkInfo.isConnect)
          //       .thenAnswer((realInvocation) async => true);
          // });
          test(
            'should return remote data when the call to remote data source is successful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getRandomNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaModel);

              /// act
              final result =
                  await repositoryImpl.getRandomNumberTrivia();

              /// assert
              verify(mockRemoteDataSource.getRandomNumberTrivia());
              expect(result, equals(Right(tnumberTrivia)));
            },
          );
          test(
            'should return server failure when the call to remote data source is unsuccessful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getRandomNumberTrivia())
                  .thenThrow(ServerException());

              /// act
              final result =
                  await repositoryImpl.getRandomNumberTrivia();

              /// assert
              verify(mockRemoteDataSource.getRandomNumberTrivia());
              verifyZeroInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerException)));
            },
          );

          test(
            'should return local data when the call to remote data source is unsuccessful ',
            () async {
              ///arrange
              when(mockRemoteDataSource.getRandomNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaModel);

              /// act
              await repositoryImpl.getRandomNumberTrivia();

              /// assert
              verify(mockRemoteDataSource.getRandomNumberTrivia());
              verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
              // expect(result, equals(Right(tnumberTrivia)));
              // expect(result, equals(Left(ServerException)));
            },
          );
        },
      );

      runTestOffline( () {
        // setUp(() {
        //   when(mockNetworkInfo.isConnect).thenAnswer((_) async => false);
        // });
        test(
          'should  return last locally cached data when the cached data is present.',
          () async {
            // arrange
            when(mockLocalDataSource.getLastnumbertrivia())
                .thenAnswer((_) async => tNumberTriviaModel);

            ///act
            final result =
                await repositoryImpl.getRandomNumberTrivia();

            ///assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastnumbertrivia());
            expect(result, equals(Right(tnumberTrivia)));
          },
        );
        test(
          'should return cache failure when there is no cached data present.',
          () async {
            // arrange
            when(mockLocalDataSource.getLastnumbertrivia())
                .thenThrow(CacheException());

            ///act
            final result =
                await repositoryImpl.getRandomNumberTrivia();

            ///assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastnumbertrivia());
            expect(result, equals(Left(CacheException())));
          },
        );
      });
    },
  );



}
