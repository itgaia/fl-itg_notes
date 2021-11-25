import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/core/error/exception.dart';
import 'package:itg_notes/src/features/notes/data/notes_local_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NotesLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NotesLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNotes', () {
    final tNotesModel = (json.decode(fixture('notes_cached.json')) as List)
      .map<NotesModel>((json) => NotesModel.fromJson(json)).toList();

    test(
        'should return Notes from SharedPreferences when there is one in cache',
        () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('notes_cached.json'));
      // act
      final result = await dataSource.getLastNotes();
      // assert
      verify(() => mockSharedPreferences.getString(cachedNotes));
      expect(result, equals(tNotesModel));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenThrow(CacheException());
      // act
      final call = dataSource.getLastNotes;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheNotes', () {
    const tNotesModel = [
      NotesModel(id: 1, title: 'test title 1', content: 'test content 1'),
      NotesModel(id: 2, title: 'test title 2', content: 'test content 2'),
      NotesModel(id: 3, title: 'test title 3', content: 'test content 3'),
    ];

    test('should call SharedPreferences to cache the data', () {
      // arrange
      when(() => mockSharedPreferences.setString(cachedNotes, any()))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheNotes(tNotesModel);
      // assert
      final expectedJsonString = json.encode(tNotesModel.map((NotesModel note) => note.toJson()).toList());
      verify(
        () => mockSharedPreferences.setString(
          cachedNotes,
          expectedJsonString,
        ),
      );
    });
  });
}
