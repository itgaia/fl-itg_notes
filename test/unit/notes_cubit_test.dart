import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/notes/note.dart';
import 'package:itg_notes/src/notes/notes_cubit.dart';

void main() {
  group('Notes Cubit', () {
    test('Default is empty', () {
      var cubit = NotesCubit();
      expect(cubit.state.notes, []);
    });

    test('add notes', () {
      var title = 'title';
      var content = 'content';
      var cubit = NotesCubit();
      cubit.createNote(title, content);
      expect(cubit.state.notes.length, 1);
      expect(cubit.state.notes.first, Note(id:1, title: title, content: content));
    });

    test('delete notes', () {
      var cubit = NotesCubit();
      cubit.createNote('title', 'content');
      cubit.createNote('another title', 'another content');
      cubit.deleteNote(1);
      expect(cubit.state.notes.length, 1);
      expect(cubit.state.notes.first.id, 2);
    });

    test('update notes', () {
      var cubit = NotesCubit();
      cubit.createNote('title', 'content');
      cubit.createNote('another title', 'another content');
      cubit.createNote('yet another title', 'yet another content');

      var newTitle = 'my cool note';
      var newContent = 'my cool note content';
      cubit.updateNote(2, newTitle, newContent);
      expect(cubit.state.notes.length, 3);
      expect(cubit.state.notes[1], Note(id: 2, title: newTitle, content: newContent));
    });
  });
}