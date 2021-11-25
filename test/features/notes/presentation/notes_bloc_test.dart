import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:itg_notes/src/core/error/failures.dart';
import 'package:itg_notes/src/core/usecases/usecase.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNotesUsecase extends Mock implements GetNotesUsecase {}

void main() {
  late NotesBloc bloc;
  late MockGetNotesUsecase mockGetNotesUsecase;

  setUp(() {
    mockGetNotesUsecase = MockGetNotesUsecase();
    bloc = NotesBloc(notes: mockGetNotesUsecase);
  });

  // Necessary setup to use Params with mocktail null safety
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  // test('initialState should be Empty', () {
  // // assert
  // expect(bloc.initialState, equals(Empty()));
  // });
  
  group('GetNotes', () {
    const tNotes = [
      NotesEntity(id: 1, title: 'test titla 1', content: 'test content 1'),
      NotesEntity(id: 2, title: 'test titla 2', content: 'test content 2'),
      NotesEntity(id: 3, title: 'test titla 3', content: 'test content 3'),
    ];

    test('should get data', () async {
      // arrange
      when(() => mockGetNotesUsecase(any()))
          .thenAnswer((_) async => const Right(tNotes));
      // act
      bloc.add(GetNotesEvent());
      await untilCalled(() => mockGetNotesUsecase(any()));
      // assert
      verify(() => mockGetNotesUsecase(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetNotesUsecase(any()))
          .thenAnswer((_) async => const Right(tNotes));
      // assert later
      final expected = [
        Loading(),
        const Loaded(notes: tNotes),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetNotesEvent());
    });

    test('should emit [Loading, Loaded, Empty] when data is gotten successfully but are empty',
        () async {
      // arrange
      when(() => mockGetNotesUsecase(any()))
          .thenAnswer((_) async => const Right([]));
      // assert later
      final expected = [
        Loading(),
        const Loaded(notes: []),
        Empty()
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetNotesEvent());
    });

    test(
        'should emit [Loading, Error] with serverFailureMessage when getting data fails with a ServerFailure',
        () async {
      // arrange
      when(() => mockGetNotesUsecase(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: serverFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetNotesEvent());
    });

    test(
        'should emit [Loading, Error] with cacheFailureMessage when getting data fails with a CacheFailure',
        () async {
      // arrange
      when(() => mockGetNotesUsecase(any()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetNotesEvent());
    });
  });
}
