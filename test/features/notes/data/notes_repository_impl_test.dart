import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:itg_notes/src/core/error/exception.dart';
import 'package:itg_notes/src/core/error/failures.dart';
import 'package:itg_notes/src/core/network/network_info.dart';
import 'package:itg_notes/src/features/notes/data/notes_local_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_model.dart';
import 'package:itg_notes/src/features/notes/data/notes_remote_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_repository_impl.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements NotesRemoteDataSource {}

class MockLocalDataSource extends Mock implements NotesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NotesRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NotesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void _runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void _runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getNotes', () {
    const tNotesModel = [
      NotesModel(id: 1, title: 'test title 1', content: 'test content 1'),
      NotesModel(id: 2, title: 'test title 2', content: 'test content 2'),
      NotesModel(id: 3, title: 'test title 3', content: 'test content 3'),
    ];
    const List<NotesEntity> tNotes = tNotesModel;

    test('should check if the device is online', () {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // don't know why this makes the test pass...
      when(() => mockRemoteDataSource.getNotes())
          .thenAnswer((_) async => tNotesModel);
      when(() => mockLocalDataSource
              .cacheNotes(tNotes as List<NotesModel>))
              // .cacheNotes(tNotes as NotesModel))
          .thenAnswer((_) async => tNotesModel);
      // act
      repository.getNotes();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    _runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getNotes())
            .thenAnswer((_) async => tNotesModel);
        when(() => mockLocalDataSource
                .cacheNotes(tNotes as List<NotesModel>))
            .thenAnswer((_) async => tNotesModel);
        // act
        final result = await repository.getNotes();
        // assert
        verify(() => mockRemoteDataSource.getNotes());
        expect(result, equals(const Right(tNotes)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getNotes())
            .thenAnswer((_) async => tNotesModel);
        when(() => mockLocalDataSource
                .cacheNotes(tNotes as List<NotesModel>))
            .thenAnswer((_) async => tNotesModel);
        // act
        await repository.getNotes();
        // assert
        verify(() => mockRemoteDataSource.getNotes());
        verify(() => mockLocalDataSource
            .cacheNotes(tNotes as List<NotesModel>));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getNotes())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNotes();
        // assert
        verify(() => mockRemoteDataSource.getNotes());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    _runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(() => mockLocalDataSource.getLastNotes())
            .thenAnswer((_) async => tNotesModel);
        // act
        final result = await repository.getNotes();
        // asssert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastNotes());
        expect(result, equals(const Right(tNotes)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(() => mockLocalDataSource.getLastNotes())
            .thenThrow(CacheException());
        // act
        final result = await repository.getNotes();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastNotes());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
