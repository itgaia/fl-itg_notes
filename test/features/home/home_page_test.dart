import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/core/custom_button.dart';
import 'package:itg_notes/src/features/home/home_page.dart';
import '../../core/test_helper.dart';

void main() {
  setUp(() async {
    await initializeAppForTesting();
    // appMainPage = CultivationChambersPage(title: ItgLocalization.tr('CultivationChambers'));
  });

  group('Home page widget tests', () {
    testWidgets('page class', (widgetTester) async {
      await testWidgetPageClass<HomePage>(widgetTester, createWidgetUnderTest);
    });

    testWidgets('page title', (widgetTester) async {
      await testWidgetPageTitle(widgetTester, createWidgetUnderTest, 'Notes App');
    });

    testWidgets('button for notes cubit', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      // var button = CustomButton(title: 'aaa', color: Colors.cyan, onPressed: () {},);
      expect(find.byType(CustomButton), findsNWidgets(2));
      // expect(find.byWidget(button), findsOneWidget);   // TODO: how can I find a specific button???
      expect(find.byKey(const Key('buttonNotesCubitPage')), findsOneWidget);
      expect(find.text('Notes Cubit Page'), findsOneWidget);
    });

    testWidgets('button for notes', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      // var button = CustomButton(title: 'aaa', color: Colors.cyan, onPressed: () {},);
      expect(find.byType(CustomButton), findsNWidgets(2));
      // expect(find.byWidget(button), findsOneWidget);   // TODO: how can I find a specific button???
      expect(find.byKey(keyButtonNotesPage), findsOneWidget);
      expect(find.text('Notes Page'), findsOneWidget);
    });
  });
}