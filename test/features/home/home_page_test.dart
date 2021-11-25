import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/src/app.dart';
import 'package:itg_notes/src/core/custom_button.dart';
import 'package:itg_notes/src/features/home/home_page.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';

void main() {
  Future<Widget> createWidgetUnderTest() async {
    final settingsController = SettingsController(SettingsService());
    await settingsController.loadSettings();
    return MyApp(settingsController: settingsController);
  }

  group('Home page widget tests', () {
    testWidgets('home page class', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('correct title', (widgetTester) async {
      await widgetTester.pumpWidget(await createWidgetUnderTest());
      expect(find.text('Notes App'), findsOneWidget);
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
      expect(find.byKey(const Key('buttonNotesPage')), findsOneWidget);
      expect(find.text('Notes Page'), findsOneWidget);
    });
  });
}