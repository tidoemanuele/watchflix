import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/features/list_titles/domain/models/title_item.dart';
import 'package:watchflix/features/list_titles/domain/repositories/i_titles_repository.dart';
import 'package:watchflix/features/list_titles/domain/usecases/get_titles_usecase.dart';

class MockTitlesRepository extends Mock implements ITitlesRepository {}

void main() {
  late GetTitlesUseCase useCase;
  late MockTitlesRepository mockRepository;

  setUp(() {
    mockRepository = MockTitlesRepository();
    useCase = GetTitlesUseCase(mockRepository);
  });

  group('GetTitlesUseCase', () {
    const sourceIds = '123,456';
    const page = 1;
    const limit = 20;

    test('should get titles from repository', () async {
      // Arrange
      final expectedTitles = [
        const TitleItem(
          id: 1,
          title: 'Test Movie',
          year: 2023,
          type: TitleType.movie,
        ),
      ];
      const expectedTotalPages = 1;

      when(
        () => mockRepository.getTitles(
          sourceIds: sourceIds,
        ),
      ).thenAnswer((_) async => (expectedTitles, expectedTotalPages));

      // Act
      final result = await useCase.execute(
        sourceIds: sourceIds,
        page: page,
        limit: limit,
      );

      // Assert
      expect(result.$1, equals(expectedTitles));
      expect(result.$2, equals(expectedTotalPages));
      verify(
        () => mockRepository.getTitles(
          sourceIds: sourceIds,
        ),
      ).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      final exception = Exception('Failed to get titles');
      when(
        () => mockRepository.getTitles(
          sourceIds: sourceIds,
        ),
      ).thenThrow(exception);

      // Act & Assert
      expect(
        () => useCase.execute(
          sourceIds: sourceIds,
          page: page,
          limit: limit,
        ),
        throwsA(equals(exception)),
      );
    });
  });
}
