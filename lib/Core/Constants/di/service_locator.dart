import 'package:get_it/get_it.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/datasource/players_data_source.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/repositories/player_repository_impl.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/repositories/player_repository.dart';
import 'package:tactix_academy_admin/Features/All%20Players/domain/usecases/get_players_usecase.dart';
import 'package:tactix_academy_admin/Features/All%20Players/presentation/bloc/players_bloc_bloc.dart';
import 'package:tactix_academy_admin/Features/Authentication/data/datasource/auth_data_source.dart';
import 'package:tactix_academy_admin/Features/Authentication/data/repositories/auth_repository_impl.dart';
import 'package:tactix_academy_admin/Features/Authentication/domain/repositories/auth_repository.dart';
import 'package:tactix_academy_admin/Features/Authentication/domain/usecases/login_use_case.dart';
import 'package:tactix_academy_admin/Features/Authentication/presentations/bloc/authentications_bloc.dart';
import 'package:tactix_academy_admin/Features/Home/data/datasource/home_screen_data_source.dart';
import 'package:tactix_academy_admin/Features/Home/data/repostiories/home_screen_repository_impl.dart';
import 'package:tactix_academy_admin/Features/Home/domain/repositories/home_screen_repository.dart';
import 'package:tactix_academy_admin/Features/Home/domain/usecases/home_use_case.dart';
import 'package:tactix_academy_admin/Features/Home/presentation/bloc/home_screen_datas_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // Authentication Dependencies
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthDataSource>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl<LoginUseCase>()),
  );

  // Home Screen Dependencies
  sl.registerLazySingleton<HomeScreenDataSource>(() => HomeScreenDataSource());
  sl.registerLazySingleton<HomeScreenRepository>(
    () => HomeScreenRepositoryImpl(sl<HomeScreenDataSource>()),
  );
  sl.registerLazySingleton<HomeUseCase>(
    () => HomeUseCase(sl<HomeScreenRepository>()),
  );
  sl.registerFactory<HomeScreenDatasBloc>(
    () => HomeScreenDatasBloc(sl<HomeUseCase>()),
  );

  // Players Dependencies
  sl.registerLazySingleton<PlayersDataSource>(() => PlayersDataSource());
  sl.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(sl<PlayersDataSource>()),
  );
  sl.registerLazySingleton<GetPlayersUsecase>(
    () => GetPlayersUsecase(sl<PlayerRepository>()),
  );
  sl.registerFactory<PlayersBloc>(
    () => PlayersBloc(sl<GetPlayersUsecase>()),
  );

  // Wait for any async initializations if needed
  await Future.wait([
    // Add any async initialization here if needed
    // Example: await sl<AuthDataSource>().initialize(),
  ]);
}