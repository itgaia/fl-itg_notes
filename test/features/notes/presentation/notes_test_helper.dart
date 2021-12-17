import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<NotesEntity> notesTestData({int count = 5}) => List.generate(
  count,
  (i) => NotesEntity(id: i, title: 'test $i', content: 'test content $i')
);

void arrangeReturnsNNotes(mockGetNotesUsecase, {int count = 5}) {
  when(() => mockGetNotesUsecase.getNotes()).thenAnswer(
          (_) async => notesTestData(count: count)
  );
}

void arrangeReturnsNNotesAfterNSecondsWait(
  mockGetNotesUsecase,
  {int count = 5, Duration wait = const Duration(seconds: 2)}) {
  when(() => mockGetNotesUsecase.getNotes()).thenAnswer(
    (_) async {
      print('>>> arrangeReturnsNNotesAfterNSecondsWait - count: $count, wait: $wait - start...');
      await Future.delayed(wait);
      print('>>> arrangeReturnsNNotesAfterNSecondsWait - count: $count, wait: $wait - end...');
      return notesTestData(count: count);
    }
  );
}

