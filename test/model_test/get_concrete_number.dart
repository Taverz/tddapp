

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/get_concrete_number_trivia.dart';
import 'package:tddapp/repository.dart';

class MockNumberTrivialRepository extends Mock 
    implements NumberTrivialRepository{}


void main() {
  late GetConcreteNumberTrivia useCase;
  late MockNumberTrivialRepository mockNumberTrivialRepository;

  setUp(() {
    mockNumberTrivialRepository = MockNumberTrivialRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTrivialRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivial();

  test('should get trivia for the number from the repository', () async{
    // arrange
    when(mockNumberTrivialRepository.getConcreteNumberTrivia(tNumber))
      .thenAnswer((_) async => Right(tNumberTrivia));
    // act
    final result = await useCase.execute(number:tNumber);
    // assets
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTrivialRepository.getConcreteNumberTrivia(42));
    verifyNoMoreInteractions(mockNumberTrivialRepository);
  });
}