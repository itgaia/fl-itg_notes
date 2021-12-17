import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:itg_notes/src/app_config.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/core/network/network_info.dart';
import 'package:itg_notes/src/core/util/input_converter.dart';
import 'package:itg_notes/src/features/notes/data/notes_local_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_remote_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_repository_impl.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_repository.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';
import 'package:itg_notes/src/features/settings/settings_controller.dart';
import 'package:itg_notes/src/features/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

// Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // if (systemInjectionInit) return;
  print('injection_container/init - start...');

  MockDataConnectionChecker mockDataConnectionChecker = MockDataConnectionChecker();
  final tHasConnectionFuture = Future.value(true);
  when(() => mockDataConnectionChecker.hasConnection)
      .thenAnswer((_) => tHasConnectionFuture);

  if (!sl.isRegistered<SettingsService>()) {
    sl.registerLazySingleton(() => SettingsService());
  }
  if (!sl.isRegistered<SettingsController>()) {
    sl.registerLazySingleton(() => SettingsController(sl()));
  }

  //! Features - Number Trivia
  if (!sl.isRegistered<NotesBloc>()) {
    sl.registerFactory(() => NotesBloc(notes: sl()));
  }

  // Use cases
  if (!sl.isRegistered<GetNotesUsecase>()) {
    sl.registerLazySingleton(() => GetNotesUsecase(sl()));
  }

  // Repository
  if (!sl.isRegistered<NotesRepository>()) {
    sl.registerLazySingleton<NotesRepository>(
            () =>
            NotesRepositoryImpl(
              remoteDataSource: sl(),
              localDataSource: sl(),
              networkInfo: sl(),
            ));
  }

  // Data sources
  if (!sl.isRegistered<NotesRemoteDataSource>()) {
    sl.registerLazySingleton<NotesRemoteDataSource>(
            () => NotesRemoteDataSourceImpl(client: sl()));
  }

  if (!sl.isRegistered<NotesLocalDataSource>()) {
    sl.registerLazySingleton<NotesLocalDataSource>(
            () => NotesLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  }

  //! Core
  if (!sl.isRegistered<InputConverter>()) {
    sl.registerLazySingleton(() => InputConverter());
  }
  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
    // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(mockDataConnectionChecker));
  }

  //! External
  if (!sl.isRegistered<SharedPreferences>()) {
    if (!systemUnderTesting) {
      final sharedPreferences = await SharedPreferences.getInstance();
      sl.registerSingletonAsync<SharedPreferences>(() async => sharedPreferences);
    }
    else {
      final mockSharedPreferences = MockSharedPreferences();
      sl.registerSingletonAsync<SharedPreferences>(() async => mockSharedPreferences);
    }
  }
  if (!sl.isRegistered<http.Client>()) {
    sl.registerLazySingleton(() => http.Client());
  }
  if (!sl.isRegistered<DataConnectionChecker>()) {
    if (kIsWeb == true) {
      print(
          '>>>>>> [injection_container.init] Warning! DataConnectionChecker is not compatible with Web! Use mocked object instead! <<<<<<');
      // TODO: temp-fix - DataConnectionChecker is not compatible with Web
    }
    sl.registerLazySingleton(() =>
    kIsWeb
        ? mockDataConnectionChecker
        : DataConnectionChecker());
  }

  // systemInjectionInit = true;
}
