import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'note.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  List _notes = [];
  int autoIncrementId = 0;

  NotesCubit() : super(NotesState(UnmodifiableListView([])));

  void createNote(String title, String content) {
    _notes.add(Note(id: ++autoIncrementId, title: title, content: content));
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void deleteNote(int id) {
    _notes = _notes.where((element) => element.id != id).toList();
    emit(NotesState(UnmodifiableListView(_notes)));
  }

  void updateNote(int id, String title, String content) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(noteIndex, noteIndex + 1, [Note(id: id, title: title, content: content)]);
    emit(NotesState(UnmodifiableListView(_notes)));
  }
}