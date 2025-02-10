import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/features/title_details/domain/repositories/i_title_details_repository.dart';
import 'package:watchflix/features/title_details/domain/usecases/get_title_details_usecase.dart';

class MockTitleDetailsRepository extends Mock
    implements ITitleDetailsRepository {}

void main() {
  late GetTitleDetailsUseCase useCase;
  late MockTitleDetailsRepository repository;

  setUp(() {
    repository = MockTitleDetailsRepository();
    useCase = GetTitleDetailsUseCase(repository as ITitleDetailsRepository);
  });

  test('should get title details from repository', () async {
    // Arrange
    const titleId = 123;
    const titleDetails = TitleDetails(
        id: titleId,
        title: 'Test',
        plotOverview: '',
        type: TitleType.movie,
        year: 1999,
        genreNames: [],
        poster: '',);
    when(() => repository.getTitleDetails(titleId))
        .thenAnswer((_) async => titleDetails);

    // Act
    final result = await useCase.execute(titleId);

    // Assert
    expect(result, titleDetails);
    verify(() => repository.getTitleDetails(titleId)).called(1);
  });
}
