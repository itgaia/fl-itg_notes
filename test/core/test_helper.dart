import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itg_notes/injection_container.dart';
import 'package:itg_notes/src/app.dart';
import 'package:itg_notes/src/app_config.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/core/network/network_info.dart';
import 'package:itg_notes/src/core/util/input_converter.dart';
import 'package:itg_notes/src/features/home/home_page.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';
import 'package:mocktail/mocktail.dart';
import '../../lib/injection_container.dart' as di;

// class MockMyBloc extends MockBloc<MyEvent, MyState> implements MyBloc {}

// class MockGetNotesUsecase extends Mock implements GetNotesUsecase {}
// class MockInputConverter extends Mock implements InputConverter {}
// class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

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

Future<void> initializeAppForTesting() async {
  systemUnderTesting = true;
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<SettingsController>().loadSettings();
  // customizeApp();
  // sl<SettingsController>().appMainPage = CultivationChambersPage(title: 'CultivationChambers',);
  // appMainPage = appPageToLoad;

  // sl.registerFactory(() => CultivationChambersBloc(cultivationChambers: sl()));
  // sl.registerLazySingleton(() => GetCultivationChambersUsecase(sl()));
  // sl.registerLazySingleton<CultivationChambersRepository>(
  //   () => CultivationChambersRepositoryImpl(
  //     remoteDataSource: sl(),
  //     localDataSource: sl(),
  //     // networkInfo: sl(),
  //   ));
  // sl.registerLazySingleton<CultivationChambersRemoteDataSource>(
  //   () => CultivationChambersRemoteDataSourceImpl(client: sl()));
  // sl.registerLazySingleton<CultivationChambersLocalDataSource>(
  //   // () => CultivationChambersLocalDataSourceImpl(sharedPreferences: sl()));
  //         () => CultivationChambersLocalDataSourceImpl());
  // // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton(() => http.Client());
  //
  // // SharedPreferences.setMockInitialValues({});  // In order to bypuss error - It could be not a good one...!
  // // final sharedPreferences = await SharedPreferences.getInstance();
  // // sl.registerSingletonAsync(() async => sharedPreferences);
  //
  // // MockDataConnectionChecker mockDataConnectionChecker = MockDataConnectionChecker();
  // // final tHasConnectionFuture = Future.value(true);
  // // when(() => mockDataConnectionChecker.hasConnection)
  // //     .thenAnswer((_) => tHasConnectionFuture);
  // // sl.registerLazySingleton(() => kIsWeb ? mockDataConnectionChecker : DataConnectionChecker());

}

Future<Widget> createWidgetUnderTest() async {
  systemUnderTesting = true;
  // WidgetsFlutterBinding.ensureInitialized();
  // await di.init();
  // final settingsController = SettingsController(SettingsService());
  // await settingsController.loadSettings();
  // return MyApp(settingsController: settingsController);
  if (!sl.isRegistered<SettingsService>()) {
    sl.registerLazySingleton(() => SettingsService());
  }
  if (!sl.isRegistered<SettingsController>()) {
    sl.registerLazySingleton(() => SettingsController(sl()));
  }
  await di.sl<SettingsController>().loadSettings();
  return const MyApp();
}

Future<void> navigateToNotesPage(WidgetTester tester) async {
  expect(find.byKey(keyButtonNotesPage), findsOneWidget);
  await tester.tap(find.byKey(keyButtonNotesPage));
  await tester.pumpAndSettle();
}

Future<void> testWidgetPageClass<T>(widgetTester, widgetUnderTest) async {
  await widgetTester.pumpWidget(await widgetUnderTest());
  expect(find.byType(T), findsOneWidget);
}

Future<void> testWidgetPageTitle(widgetTester, widgetUnderTest, title) async {
  await widgetTester.pumpWidget(await widgetUnderTest());
  expect(find.text(title), findsOneWidget);
}

// testWidgets('correct title', (widgetTester) async {
// await widgetTester.pumpWidget(await createWidgetUnderTest());
// expect(find.text('Notes App'), findsOneWidget);
// });
