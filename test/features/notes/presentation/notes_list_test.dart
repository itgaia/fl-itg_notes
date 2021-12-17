import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itg_notes/src/app.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_entity.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_list.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_page.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/bottom_loader.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/notes_list_item.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../lib/injection_container.dart' as di;
import '../../../core/test_helper.dart';
import 'notes_test_helper.dart';

class MockNotesBloc extends MockBloc<NotesEvent, NotesState> implements NotesBloc {}
class NotesStateFake extends Fake implements NotesState {}
class NotesEventFake extends Fake implements NotesEvent {}

extension on WidgetTester {
  Future<void> pumpNotesList(NotesBloc noteBloc) async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await di.init();
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: noteBloc,
          child: NotesList(),
        ),
      ),
    );
  }
}

void main() {
  final mockNotes = List.generate(
    5,
    (i) => NotesEntity(id: i, title: 'note title $i', content: 'note body $i'),
  );

  // late NotesBlocbloc;
  late MockNotesBloc mockNotesBloc;
  late MockGetNotesUsecase mockGetNotesUsecase;

  setUpAll(() {
    // registerFallbackValue(NotesStateFake());
    // registerFallbackValue(NotesEventFake());
  });

  setUp(() async {
    registerFallbackValue(NotesStateFake());
    registerFallbackValue(NotesEventFake());
    await initializeAppForTesting();
    appMainPage = const NotesPage(title: 'Notes');
    // mockNotesBloc = MockNoteBloc();
    mockGetNotesUsecase = MockGetNotesUsecase();
    mockNotesBloc = MockNotesBloc();
  });

  Future<Widget> _createWidgetUnderTest() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await di.init();
    // final settingsController = SettingsController(SettingsService());
    // await settingsController.loadSettings();
    // appMainPage = NotesList();
    // return MyApp(settingsController: settingsController);
    return const MyApp();
  }

  group('NotesList', () {
    testWidgets(
        'renders CircularProgressIndicator when state is loading', (tester) async {
      when(() => mockNotesBloc.state).thenReturn(Loading());
      await tester.pumpNotesList(mockNotesBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'loading indicator is diplayed while wait for articles',
          (WidgetTester tester) async {
        arrangeReturnsNNotesAfterNSecondsWait(mockGetNotesUsecase);
        // await tester.pumpNotesList(mockNotesBloc);
        await tester.pumpWidget(await _createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byKey(keyProgressIndicatorMain), findsOneWidget);
        await tester.pumpAndSettle();
      }
    );

    testWidgets(
        'renders no notes text '
        'when note status is success but with 0 notes', (tester) async {
      when(() => mockNotesBloc.state).thenReturn(Empty());
      await tester.pumpNotesList(mockNotesBloc);
      expect(find.text('no notes'), findsOneWidget);
    });

    testWidgets(
        'renders 5 notes and a bottom loader when note max is not reached yet',
        (tester) async {
      when(() => mockNotesBloc.state).thenReturn(Loaded(notes: mockNotes));
      await tester.pumpNotesList(mockNotesBloc);
      expect(find.byType(NotesListItem), findsNWidgets(5));
      expect(find.byType(BottomLoader), findsOneWidget);
    });

    testWidgets('does not render bottom loader when note max is reached',
        (tester) async {
      when(() => mockNotesBloc.state).thenReturn(Loaded(
        notes: mockNotes,
        hasReachedMax: true,
      ));
      await tester.pumpNotesList(mockNotesBloc);
      expect(find.byType(BottomLoader), findsNothing);
    });

    testWidgets('fetches more notes when scrolled to the bottom',
        (tester) async {
      when(() => mockNotesBloc.state).thenReturn(
        Loaded(
          notes: List.generate(
            10,
            (i) => NotesEntity(id: i, title: 'note title $i', content: 'note body $i'),
          ),
        ),
      );
      await tester.pumpNotesList(mockNotesBloc);
      await tester.drag(find.byType(NotesList), const Offset(0, -500));
      verify(() => mockNotesBloc.add(GetNotesEvent())).called(1);
    });
  });
}
