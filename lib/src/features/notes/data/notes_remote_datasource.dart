import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itg_notes/src/app_private_config.dart';
import 'package:itg_notes/src/core/error/exception.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';

import 'notes_model.dart';

abstract class NotesRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<NotesEntity>> getNotes();
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  final http.Client client;

  NotesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NotesModel>> getNotes() async =>
      _getNotesFromUrl(serverUrl);

  Future<List<NotesModel>> _getNotesFromUrl(String url) async {
    final notesUrl = Uri.parse(url);
    final response = await client.get(
      notesUrl,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // return NotesModel.fromJson(
      //     json.decode(response.body) as Map<String, dynamic>);
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return NotesModel(
          id: json['id'] as int,
          title: json['title'] as String,
          content: json['content'] as String,
        );
      }).toList();
    } else {
      throw ServerException();
    }
  }
}
