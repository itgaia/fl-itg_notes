import '../domain/notes_entity.dart';

class NotesModel extends NotesEntity {
  const NotesModel({
    required int id,
    required String title,
    required String content,
  }) : super(id: id, title: title, content: content);

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: (json['id'] as num).toInt(),
      title: json['title'].toString(),
      content: json['content'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
