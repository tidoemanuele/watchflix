import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchflix/api/gen/watchmode_api.enums.swagger.dart';
import 'package:watchflix/api/gen/watchmode_api.models.swagger.dart';
import 'package:watchflix/core/utils/result.dart';
import 'package:watchflix/features/title_details/domain/usecases/get_title_details_usecase.dart';
import 'package:watchflix/features/title_details/presentation/cubit/title_details_cubit.dart';

class MockGetTitleDetailsUseCase extends Mock
    implements GetTitleDetailsUseCase {}

void main() {
  group('TitleDetailsCubit', () {
    late TitleDetailsCubit cubit;
    late MockGetTitleDetailsUseCase useCase;

    setUp(() {
      useCase = MockGetTitleDetailsUseCase();
      cubit = TitleDetailsCubit(useCase);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is Loading', () {
      expect(cubit.state, const Loading<TitleDetails>());
    });

    group('loadDetails', () {
      const titleId = 123;
      const titleDetails = TitleDetails(
        id: titleId,
        title: 'Test Movie',
        plotOverview: 'Test Overview',
        type: TitleType.movie,
        year: 2023,
        genreNames: ['Action', 'Drama'],
        userRating: 4.5,
        criticScore: 85,
        poster: 'poster_url',
        backdrop: 'backdrop_url',
        relevancePercentile: 95.5,
      );

      test('emits [Loading, Success] when useCase call succeeds', () async {
        // Arrange
        when(() => useCase.execute(titleId))
            .thenAnswer((_) async => titleDetails);

        // Act
        await cubit.loadDetails(titleId);

        // Assert
        verify(() => useCase.execute(titleId)).called(1);

        final state = cubit.state as Success<TitleDetails>;
        expect(state.data.id, titleDetails.id);
        expect(state.data.title, titleDetails.title);
        expect(state.data.plotOverview, titleDetails.plotOverview);
        expect(state.data.type, titleDetails.type);
        expect(state.data.year, titleDetails.year);
        expect(state.data.genreNames, titleDetails.genreNames);
        expect(state.data.userRating, titleDetails.userRating);
        expect(state.data.criticScore, titleDetails.criticScore);
        expect(state.data.poster, titleDetails.poster);
        expect(state.data.backdrop, titleDetails.backdrop);
        expect(
            state.data.relevancePercentile, titleDetails.relevancePercentile,);
      });

      test('emits [Loading, Error] when useCase call fails', () async {
        // Arrange
        final exception = Exception('Network error');
        when(() => useCase.execute(titleId)).thenThrow(exception);

        // Act
        await cubit.loadDetails(titleId);

        // Assert
        verify(() => useCase.execute(titleId)).called(1);
        expect(
          cubit.state,
          isA<Error<TitleDetails>>().having(
            (error) => error.message,
            'message',
            exception.toString(),
          ),
        );
      });

      test(
          'cancels previous subscription when loadDetails is called multiple times',
          () async {
        // Arrange
        when(() => useCase.execute(any()))
            .thenAnswer((_) async => titleDetails);

        // Act
        await cubit.loadDetails(1);
        await cubit.loadDetails(2);

        // Assert
        verify(() => useCase.execute(1)).called(1);
        verify(() => useCase.execute(2)).called(1);
        expect(
          cubit.state,
          isA<Success<TitleDetails>>().having(
            (success) => success.data,
            'data',
            titleDetails,
          ),
        );
      });
    });
  });
}
