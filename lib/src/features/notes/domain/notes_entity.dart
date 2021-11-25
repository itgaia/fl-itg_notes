import 'package:equatable/equatable.dart';

class NotesEntity extends Equatable {
  const NotesEntity({required this.id, required this.title, required this.content});

  final int id;
  final String title;
  final String content;

  @override
  List<Object> get props => [id, title, content];
}
