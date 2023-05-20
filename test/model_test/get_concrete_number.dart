

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/get_concrete_number_trivia.dart';
import 'package:tddapp/repository.dart';

class MockNumberTrivialRepository extends Mock 
    implements NumberTrivialRepository{}


void main() {
  GetConcreteNumberTrivia useCase;
  MockNumberTrivialRepository mockNumberTrivialRepository;

  setUp(() {
    mockNumberTrivialRepository = MockNumberTrivialRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTrivialRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivial();

  test('should get trivia for the number from the repository', () async{
    // arrange

    // act

    // assets

  });
}