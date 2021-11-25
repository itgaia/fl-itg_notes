import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:itg_notes/src/core/error/failures.dart';
import 'package:itg_notes/src/core/usecases/usecase.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';

part 'notes_event.dart';
part 'notes_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUsecase getNotesUsecase;

  NotesBloc({
    required GetNotesUsecase notes,
  })  : getNotesUsecase = notes,
        super(Empty());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is GetNotesEvent) {
      print('mapEventToState - 1');
      yield Loading();
      print('mapEventToState - 2');
      final failureOrNotes = await getNotesUsecase(NoParams());
      print('mapEventToState - 3');
      yield* _eitherLoadedOrErrorState(failureOrNotes);
      print('mapEventToState - 4');
      if (failureOrNotes.isRight()) {
        final notes = failureOrNotes.toOption().toNullable()!;
        if (notes.isEmpty) yield Empty();
      }
    }
  }

  Stream<NotesState> _eitherLoadedOrErrorState(
      Either<Failure, List<NotesEntity>> failureOrNotes) async* {
    yield failureOrNotes.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (notes) => Loaded(notes: notes));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
