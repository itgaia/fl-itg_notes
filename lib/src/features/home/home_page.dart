import 'package:flutter/material.dart';
import 'package:itg_notes/src/core/custom_button.dart';
import 'package:itg_notes/src/features/notes_cubit/notes_cubit_page.dart';

import '../settings/settings_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      body: ListTile(
        // title: Text('aaaaa'),
        leading: CustomButton(
          title: 'Notes Cubit Page',
          color: Colors.cyan,
          onPressed: () {
            Navigator.restorablePushNamed(
              context,
              NotesCubitPage.routeName,
            );
          },
          key: const Key('buttonNotesCubitPage')
        ),
        // leading: const CircleAvatar(
        //   foregroundImage: AssetImage('assets/images/flutter_logo.png'),
        // ),
        onTap: () {
          Navigator.restorablePushNamed(
            context,
            NotesCubitPage.routeName,
          );
        }
      )
    );
  }
}