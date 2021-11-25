import 'package:flutter/material.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({Key? key, required this.note}) : super(key: key);

  final NotesEntity note;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${note.id}', style: textTheme.caption),
        title: Text(note.title),
        isThreeLine: true,
        subtitle: Text(note.content),
        dense: true,
      ),
    );
  }
}
