import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/enitites/number_trivia.dart';
import 'package:tddapp/get_concrete_number_trivia.dart';
import 'package:tddapp/repository.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTrivialRepository {}

//modified
// @GenerateMocks([NumberTrivialRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivial(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any)).thenAnswer(
        (Invocation _) async {
          return Right(tNumberTrivia);
        },
      );
      // act
      final result = await usecase(ParamsW(number: tNumber));
      // assert
      expect(result, Right(tNumberTrivia));
      verifyNever(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
