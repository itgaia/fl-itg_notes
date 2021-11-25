import 'package:dartz/dartz.dart';
import 'package:itg_notes/src/core/error/exception.dart';
import 'package:itg_notes/src/core/error/failures.dart';
import 'package:itg_notes/src/core/network/network_info.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:itg_notes/src/features/notes/domain/notes_repository.dart';

import 'notes_local_datasource.dart';
import 'notes_model.dart';
import 'notes_remote_datasource.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;
  final NotesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NotesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<NotesEntity>>> getNotes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNotes = await remoteDataSource.getNotes();
        localDataSource.cacheNotes(remoteNotes as List<NotesModel>);
        return Right(remoteNotes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNotes = await localDataSource.getLastNotes();
        return Right(localNotes);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
