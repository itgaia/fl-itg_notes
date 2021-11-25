import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/features/notes/data/notes_model.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tNotesModel = [
    NotesModel(id: 1, title: 'test title 1', content: 'test content 1'),
    NotesModel(id: 2, title: 'test title 2', content: 'test content 2'),
    NotesModel(id: 3, title: 'test title 3', content: 'test content 3'),
  ];

  test(
    'should be a subclass of Notes entity',
    () async {
      expect(tNotesModel.first, isA<NotesEntity>());
    },
  );

  group('fromJson', () {
    test('should return a valid model from JSON',
        () async {
      // arrange
      final result = (json.decode(fixture('notes.json')) as List)
        .map<NotesModel>((json) => NotesModel.fromJson(json)).toList();
      // act
      // assert
      expect(result, tNotesModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tNotesModel.map((NotesModel note) => note.toJson()).toList();
      // assert
      final expectedJsonMap = [
        {
          "id": 1,
          "title": "test title 1",
          "content": "test content 1"
        },
        {
          "id": 2,
          "title": "test title 2",
          "content": "test content 2"
        },
        {
          "id": 3,
          "title": "test title 3",
          "content": "test content 3"
        }
      ];
      expect(result, expectedJsonMap);
    });
  });
}
