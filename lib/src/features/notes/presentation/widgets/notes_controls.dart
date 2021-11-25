import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';

class NotesControls extends StatefulWidget {
  const NotesControls({
    Key? key,
  }) : super(key: key);

  @override
  _NotesControlsState createState() => _NotesControlsState();
}

class _NotesControlsState extends State<NotesControls> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('>>>>>>> notes_controls......');
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        // style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
        onPressed: dispatchNotes,
        child: const Text('Get notes'),
      ),
    );
  }

  void dispatchNotes() {
    controller.clear();
    BlocProvider.of<NotesBloc>(context).add(GetNotesEvent());
  }
}
