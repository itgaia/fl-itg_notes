import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_list.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/injection_container.dart' as di;
import 'package:itg_notes/src/app.dart';
import 'package:itg_notes/src/features/home/home_page.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_page.dart';
import 'package:itg_notes/src/features/notes_cubit/notes_cubit.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// class MockNotesBloc extends MockBloc<NotesEvent, NotesState> implements NotesBloc {}
// class NotesStateFake extends Fake implements NotesState {}

void main() {
  // late MockNotesBloc mockNotesBloc;
  // late NotesStateFake fakeNotesState;
  // setUpAll(() {
  //   print('>>>>>>>>>>>>> setUpAll.....');
  //   mockNotesBloc = MockNotesBloc();
  //   fakeNotesState = NotesStateFake();
  //   registerFallbackValue(fakeNotesState);
  // });

  // Future<Widget> createWidgetUnderTest() async {
  //   final settingsController = SettingsController(SettingsService());
  //   await settingsController.loadSettings();
  //   // return MyApp(settingsController: settingsController);
  //   return AnimatedBuilder(
  //     animation: settingsController,
  //     builder: (BuildContext context, Widget? child) {
  //       return MaterialApp(
  //         // Providing a restorationScopeId allows the Navigator built by the
  //         // MaterialApp to restore the navigation stack when a user leaves and
  //         // returns to the app after it has been killed while running in the
  //         // background.
  //         restorationScopeId: 'app',
  //
  //         // Provide the generated AppLocalizations to the MaterialApp. This
  //         // allows descendant Widgets to display the correct translations
  //         // depending on the user's locale.
  //         localizationsDelegates: const [
  //           AppLocalizations.delegate,
  //           GlobalMaterialLocalizations.delegate,
  //           GlobalWidgetsLocalizations.delegate,
  //           GlobalCupertinoLocalizations.delegate,
  //         ],
  //         supportedLocales: const [
  //           Locale('en', ''), // English, no country code
  //         ],
  //
  //         // Use AppLocalizations to configure the correct application title
  //         // depending on the user's locale.
  //         //
  //         // The appTitle is defined in .arb files found in the localization
  //         // directory.
  //         onGenerateTitle: (BuildContext context) =>
  //         AppLocalizations.of(context)!.appTitle,
  //
  //         // Define a light and dark color theme. Then, read the user's
  //         // preferred ThemeMode (light, dark, or system default) from the
  //         // SettingsController to display the correct theme.
  //         theme: ThemeData(),
  //         darkTheme: ThemeData.dark(),
  //         themeMode: settingsController.themeMode,
  //
  //         // Define a function to handle named routes in order to support
  //         // Flutter web url navigation and deep linking.
  //         onGenerateRoute: (RouteSettings routeSettings) {
  //           return MaterialPageRoute<void>(
  //             settings: routeSettings,
  //             builder: (BuildContext context) {
  //               switch (routeSettings.name) {
  //                 // case SettingsView.routeName:
  //                 //   return SettingsView(controller: settingsController);
  //                 // case SampleItemDetailsView.routeName:
  //                 //   return const SampleItemDetailsView();
  //                 case NotesPage.routeName:
  //                 default:
  //                   // return NotesPage(notesCubit: NotesCubit(), title: 'Notes');
  //                   return const NotesPage(title: 'Notes');
  //               }
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  Future<Widget> _createWidgetUnderTest() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await di.init();
    final settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();
    return MyApp(settingsController: settingsController);
  }

  Future<void> _navigateToNotesPage(WidgetTester tester) async {
    expect(find.byKey(HomePage.keyButtonNotesPage), findsOneWidget);
    await tester.tap(find.byKey(HomePage.keyButtonNotesPage));
    await tester.pumpAndSettle();
  }

  group('Notes page widget tests', () {
    test('correct route name', () {
      expect(NotesPage.routeName, '/notes');
    });

    // testWidgets('renders NotesList', (tester) async {
    //   // WidgetsFlutterBinding.ensureInitialized();
    //   print('00000');
    //   await di.init();
    //   print('11111');
    //   await tester.pumpWidget(MaterialApp(home: NotesPage(title: 'Notes',)));
    //   print('2222');
    //   await tester.pumpAndSettle();
    //   print('3333');
    //   expect(find.byType(NotesList), findsOneWidget);
    // });

    // testWidgets('notes page class', (widgetTester) async {
    //   final NotesStateFake fakeNotesState = NotesStateFake();
    //   print('>>>>>>>>>>>>> regsterFallbackValue.....');
    //   registerFallbackValue(fakeNotesState);
    //
    //   final mockNotesBloc = MockNotesBloc();
    //
    //   // Stub the state stream
    //   whenListen(
    //     mockNotesBloc,
    //     Stream.fromIterable([0, 1, 2, 3]),
    //     initialState: 0,
    //   );
    //
    //   await widgetTester.pumpWidget(await _createWidgetUnderTest());
    //   expect(find.byType(HomePage), findsOneWidget);
    //   await _navigateToNotesPage(widgetTester);
    //   expect(find.byType(NotesPage), findsOneWidget);
    // });
    //
    // testWidgets('correct title', (widgetTester) async {
    //   await widgetTester.pumpWidget(await _createWidgetUnderTest());
    //   expect(find.text('Notes'), findsOneWidget);
    // });
  });
}