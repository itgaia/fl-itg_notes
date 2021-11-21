import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_cubit.dart';
import 'note_cubit_page.dart';
import 'notes_cubit.dart';
import 'notes_cubit_state.dart';

class NotesCubitPage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  const NotesCubitPage({Key? key, required this.title, required this.notesCubit}) : super(key: key);

  static const routeName = '/cubit/notes';

  // Sending the Note to the next page:
  _goToNotePage(BuildContext context, {NoteCubit? note}) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NoteCubitPage(
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
      body: BlocBuilder<NotesCubit, NotesCubitState>(
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
