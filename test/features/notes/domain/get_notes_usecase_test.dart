import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:itg_notes/src/core/usecases/usecase.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:itg_notes/src/features/notes/domain/notes_repository.dart';

class MockNotesRepository extends Mock
    implements NotesRepository {}

void main() {
  late GetNotesUsecase usecase;
  late MockNotesRepository mockNotesRepository;

  setUp(() {
    mockNotesRepository = MockNotesRepository();
    usecase = GetNotesUsecase(mockNotesRepository);
  });

  const tNotes = [
    NotesEntity(id: 1, title: 'test title 1', content: 'test content 1'),
    NotesEntity(id: 2, title: 'test title 2', content: 'test content 2'),
    NotesEntity(id: 3, title: 'test title 3', content: 'test content 3'),
  ];

  test(
    'should get notes from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNotes is called with any argument, always answer with
      // the Right "side" of Either containing a test Notes object.
      when(() => mockNotesRepository.getNotes())
          .thenAnswer((_) async => const Right(tNotes));

      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(NoParams());

      // UseCase should simply return whatever was returned from the Repository
      expect(result, const Right(tNotes));

      // Verify that the method has been called on the Repository
      verify(() => mockNotesRepository.getNotes());

      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNotesRepository);
    },
  );
}
