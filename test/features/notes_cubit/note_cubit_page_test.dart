import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/common/itg_localization.dart';
import 'package:itg_notes/src/features/notes_cubit/note_cubit_page.dart';
import 'package:itg_notes/src/features/notes_cubit/notes_cubit.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';

void main() {
  Future<Widget> createWidgetUnderTest() async {
    final settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();
    // return MyApp(settingsController: settingsController);
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
                  // case SettingsView.routeName:
                  //   return SettingsView(controller: settingsController);
                  // case SampleItemDetailsView.routeName:
                  //   return const SampleItemDetailsView();
                  case NoteCubitPage.routeName:
                  default:
                    return NoteCubitPage(notesCubit: NotesCubit());
                }
              },
            );
          },
        );
      },
    );
  }

  group('Notes page widget tests', () {
    testWidgets('notes page class', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      expect(find.byType(NoteCubitPage), findsOneWidget);
    });

    testWidgets('correct title', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      expect(find.text('Note Cubit'), findsOneWidget);
    });

    test('correct route name', () {
      expect(NoteCubitPage.routeName, '/cubit/note');
    });
  });
}