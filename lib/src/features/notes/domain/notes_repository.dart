import 'package:dartz/dartz.dart';

import 'package:itg_notes/src/core/error/failures.dart';
import 'notes_entity.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<NotesEntity>>> getNotes();
}
