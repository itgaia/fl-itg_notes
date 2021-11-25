import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:itg_notes/src/core/network/network_info.dart';
import 'package:itg_notes/src/core/util/input_converter.dart';
import 'package:itg_notes/src/features/notes/data/notes_local_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_remote_datasource.dart';
import 'package:itg_notes/src/features/notes/data/notes_repository_impl.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';
import 'package:itg_notes/src/features/notes/domain/notes_repository.dart';
import 'package:itg_notes/src/features/notes/presentation/notes_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

// Service Locator
final sl = GetIt.instance;

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

Future<void> init() async {
  MockDataConnectionChecker mockDataConnectionChecker = MockDataConnectionChecker();
  final tHasConnectionFuture = Future.value(true);
  when(() => mockDataConnectionChecker.hasConnection)
    .thenAnswer((_) => tHasConnectionFuture);

  //! Features - Number Trivia
  sl.registerFactory(() => NotesBloc(notes: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetNotesUsecase(sl()));

  // Repository
  sl.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<NotesRemoteDataSource>(
      () => NotesRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NotesLocalDataSource>(
      () => NotesLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(mockDataConnectionChecker));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingletonAsync(() async => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  if (kIsWeb == true) {
    print('>>>>>> [injection_container.init] Warning! DataConnectionChecker is not compatible with Web! Use mocked object instead! <<<<<<');
    // TODO: temp-fix - DataConnectionChecker is not compatible with Web
  }
  sl.registerLazySingleton(() => kIsWeb ? mockDataConnectionChecker : DataConnectionChecker());
}
