import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'note_cubit.dart';
import 'notes_cubit.dart';


class NoteCubitPage extends StatefulWidget {
  final NotesCubit notesCubit;
  NoteCubit? note;

  NoteCubitPage({Key? key, required this.notesCubit, this.note}) : super(key: key);

  static const routeName = '/cubit/note';

  @override
  _NoteCubitPageState createState() => _NoteCubitPageState();
}

class _NoteCubitPageState extends State<NoteCubitPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note == null) return;
    _titleController.text = widget.note!.title;
    _contentController.text = widget.note!.content;
  }

  _deleteNote() {
    widget.notesCubit.deleteNote(widget.note!.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Cubit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.note != null ? _deleteNote : null,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('title'),
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                key: const ValueKey('content'),
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                maxLines: 500,
                decoration:
                const InputDecoration(hintText: 'Enter your text here...'),
              ),
            ),
            RaisedButton(
              child: const Text('Ok'),
              onPressed: () => _finishEditing(),
            )
          ],
        ),
      ),
    );
  }

  _finishEditing() {
    if (widget.note != null) {
      widget.notesCubit.updateNote(
          widget.note!.id, _titleController.text, _contentController.text);
    } else {
      widget.notesCubit.createNote(_titleController.text, _contentController.text);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }
}