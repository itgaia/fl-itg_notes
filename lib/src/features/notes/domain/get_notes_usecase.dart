import 'package:dartz/dartz.dart';
import 'package:itg_notes/src/core/error/failures.dart';
import 'package:itg_notes/src/core/usecases/usecase.dart';

import 'notes_entity.dart';
import 'notes_repository.dart';

class GetNotesUsecase implements UseCase<List<NotesEntity>, NoParams> {
  final NotesRepository repository;

  GetNotesUsecase(this.repository);

  @override
  Future<Either<Failure, List<NotesEntity>>> call(NoParams params) async {
    return repository.getNotes();
  }
}
