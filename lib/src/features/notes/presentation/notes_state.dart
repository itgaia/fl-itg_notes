part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class Empty extends NotesState {}

class Loading extends NotesState {}

class Loaded extends NotesState {
  final List<NotesEntity> notes;
  final bool hasReachedMax;

  const Loaded({
    required this.notes,
    this.hasReachedMax = false,
  });
}

class Error extends NotesState {
  final String message;

  const Error({required this.message});
}
