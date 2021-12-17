import 'package:flutter/material.dart';
import 'package:itg_notes/src/features/home/home_page.dart';

import '../injection_container.dart';
import 'app_helper.dart';
import 'common/itg_localization.dart';
import 'features/notes/presentation/note_page.dart';
import 'features/notes/presentation/notes_page.dart';
import 'features/notes_cubit/note_cubit_page.dart';
import 'features/notes_cubit/notes_cubit.dart';
import 'features/notes_cubit/notes_cubit_page.dart';
import 'features/settings/settings_controller.dart';
import 'features/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    // required this.settingsController,
  }) : super(key: key);

  // final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = sl();
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          onGenerateTitle: (BuildContext context) => ItgLocalization.tr('appTitle'),

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case NotesCubitPage.routeName:
                    return NotesCubitPage(notesCubit: NotesCubit(), title: 'Notes Cubit',);
                  case NoteCubitPage.routeName:
                    return NoteCubitPage(notesCubit: NotesCubit(),);
                  case NotesPage.routeName:
                    // return NotesPage(notesCubit: NotesCubit(), title: 'Notes',);
                    return const NotesPage(title: 'Notes');
                  // case NotePage.routeName:
                  //   return NotePage(notesCubit: NotesCubit(),);
                  case HomePage.routeName:
                  default:
                    // return const HomePage();
                    return appMainPage;
                }
              },
            );
          },
        );
      },
    );
  }
}
