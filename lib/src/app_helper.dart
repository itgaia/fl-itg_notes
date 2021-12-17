import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/home/home_page.dart';
import 'features/notes/domain/get_notes_usecase.dart';
import 'features/notes/presentation/notes_bloc.dart';

// Exists here for the temp fix of the issue with DataConnectionChecker in Web
class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}
class MockGetNotesUsecase extends Mock implements GetNotesUsecase {}
class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockInputConverter extends Mock implements InputConverter {}
class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

Widget appMainPage = const HomePage();

const keyButtonNotesPage = Key('button-notes-page');
const keyProgressIndicatorMain = Key('progress-indicator-main');
