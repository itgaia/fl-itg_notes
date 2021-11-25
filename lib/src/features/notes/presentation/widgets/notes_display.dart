import 'package:flutter/material.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';

class NotesDisplay extends StatelessWidget {
  final NotesEntity notes;
  const NotesDisplay({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('>>>>>>> notes_display......');
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Expanded(
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              notes.toString(),
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
