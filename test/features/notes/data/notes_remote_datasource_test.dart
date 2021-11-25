import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/app_private_config.dart';
import 'package:itg_notes/src/core/error/exception.dart';
import 'package:itg_notes/src/features/notes/data/notes_model.dart';
import 'package:itg_notes/src/features/notes/data/notes_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NotesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NotesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpHttpClientSuccess200(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('notes.json'), 200));
  }

  void setUpHttpClientFailure404(Uri url) {
    when(() => mockHttpClient.get(url, headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getNotes', () {
    final url = Uri.parse(serverUrl);

    test(
        'should perform a GET request on a URL with application/json header',
        () {
      // arrange
      setUpHttpClientSuccess200(url);
      // act
      dataSource.getNotes();
      // assert
      verify(() => mockHttpClient
          .get(url, headers: {'Content-Type': 'application/json'}));
    });

    final tNotesModel = (json.decode(fixture('notes.json')) as List)
      .map<NotesModel>((json) => NotesModel.fromJson(json)).toList();

    test('should return Notes when the response code is 200', () async {
      // arrange
      setUpHttpClientSuccess200(url);
      // act
      final result = await dataSource.getNotes();
      // assert
      expect(result, equals(tNotesModel));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpHttpClientFailure404(url);
      // act
      final call = dataSource.getNotes;
      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
