import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/features/sources/domain/models/source_category.dart';
import 'package:watchflix/features/sources/domain/repositories/i_sources_repository.dart';
import 'package:watchflix/features/sources/domain/usecases/get_sources_usecase.dart';

class MockSourcesRepository extends Mock implements ISourcesRepository {}

void main() {
  late GetSourcesUseCase useCase;
  late MockSourcesRepository mockRepository;

  setUp(() {
    mockRepository = MockSourcesRepository();
    useCase = GetSourcesUseCase(mockRepository);
  });

  test('should return categorized sources when repository call is successful',
      () async {
    // Arrange
    final sources = [
      const SourceSummary(
        id: 1,
        name: 'Netflix',
        type: SourceType.sub,
        logo100px: 'logo_url',
        regions: ['US'],
      ),
      const SourceSummary(
        id: 2,
        name: 'YouTube',
        type: SourceType.free,
        logo100px: 'logo_url',
        regions: ['US'],
      ),
    ];

    when(() => mockRepository.getSources())
        .thenAnswer((_) async => CategoryizedSources.fromSourcesList(sources));

    // Act
    final result = await useCase.execute();

    // Assert
    expect(result.subscriptionSources.length, equals(1));
    expect(result.freeSources.length, equals(1));
    verify(() => mockRepository.getSources()).called(1);
  });

  test('should throw exception when repository call fails', () async {
    // Arrange
    when(() => mockRepository.getSources())
        .thenThrow(Exception('Failed to load sources'));

    // Act & Assert
    expect(
      () => useCase.execute(),
      throwsA(isA<Exception>()),
    );
    verify(() => mockRepository.getSources()).called(1);
  });
}
