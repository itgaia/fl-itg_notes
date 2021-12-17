import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/injection_container.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/core/usecases/usecase.dart';
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

import '../../../core/test_helper.dart';

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

  late NotesBloc bloc;
  late MockGetNotesUsecase mockGetNotesUsecase;

  setUpAll(() {
    // Necessary setup to use Params with mocktail null safety
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetNotesUsecase = MockGetNotesUsecase();
    bloc = NotesBloc(notes: mockGetNotesUsecase);
  });

  setUpAll(() async {
    sl.registerFactory(() => NotesBloc(notes: sl()));
  });

  group('Notes page widget tests', () {
    test('correct route name', () {
      expect(NotesPage.routeName, '/notes');
    });

    testWidgets('page class', (widgetTester) async {
      await testWidgetPageClass<HomePage>(widgetTester, createWidgetUnderTest);
    });

    testWidgets('page title', (widgetTester) async {
      await testWidgetPageTitle(widgetTester, createWidgetUnderTest, 'Notes App');
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