import 'dart:convert';

import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exception.dart';
import 'notes_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NotesEntity>> getLastNotes();

  Future<void> cacheNotes(List<NotesModel> notesToCache);
}

const cachedNotes = 'CACHED_NOTES';

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final SharedPreferences sharedPreferences;

  NotesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NotesModel>> getLastNotes() {
    final jsonString = sharedPreferences.getString(cachedNotes);
    if (jsonString != null) {
      final body = json.decode(jsonString) as List;
      return Future.value(
        // NotesModel.fromJson(
        //   json.decode(jsonString) as Map<String, dynamic>,
        // ),
      body.map((dynamic json) {
        return NotesModel(
          id: json['id'] as int,
          title: json['title'] as String,
          content: json['content'] as String,
        );
      }).toList()
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNotes(List<NotesModel> notesToCache) {
    return sharedPreferences.setString(
      cachedNotes,
      json.encode(notesToCache.map((NotesModel note) => note.toJson()).toList()),
    );
  }
}
