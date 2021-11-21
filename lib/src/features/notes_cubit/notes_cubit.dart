import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_cubit.dart';
import 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  List _notes = [];
  int autoIncrementId = 0;

  NotesCubit() : super(NotesCubitState(UnmodifiableListView([])));

  void createNote(String title, String content) {
    _notes.add(NoteCubit(id: ++autoIncrementId, title: title, content: content));
    emit(NotesCubitState(UnmodifiableListView(_notes)));
  }

  void deleteNote(int id) {
    _notes = _notes.where((element) => element.id != id).toList();
    emit(NotesCubitState(UnmodifiableListView(_notes)));
  }

  void updateNote(int id, String title, String content) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(noteIndex, noteIndex + 1, [NoteCubit(id: id, title: title, content: content)]);
    emit(NotesCubitState(UnmodifiableListView(_notes)));
  }
}