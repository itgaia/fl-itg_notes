import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note.dart';
import 'note_page.dart';
import 'notes_cubit.dart';
import 'notes_state.dart';

class NotesPage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  const NotesPage({Key? key, required this.title, required this.notesCubit}) : super(key: key);

  static const routeName = '/notes';

  // Sending the Note to the next page:
  _goToNotePage(BuildContext context, {Note? note}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NotePage(
        notesCubit: notesCubit,
        note: note,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        bloc: notesCubit,
        builder: (context, state) => ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            var note = state.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              onTap: () => _goToNotePage(context, note: note),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNotePage(context),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
