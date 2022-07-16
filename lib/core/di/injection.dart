import 'package:clean_arctect/core/util/cubit/app_cubit.dart';
import 'package:clean_arctect/core/util/network/local/cache_helper.dart';
import 'package:clean_arctect/core/util/network/remote/dio_helper.dart';
import 'package:clean_arctect/core/util/resources/routes_manager.dart';
import 'package:clean_arctect/features/splash/data/remote/get_user_remote.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc

  sl.registerFactory(
    () => AppCubit(
      repository: sl(),
    ),
  );

  // Use cases

  // Repository
  sl.registerLazySingleton<RemoteGerUser>(
    () => RemoteGerUser(
      dioHelper: sl(),
      // cacheHelper: sl(),
    ),
  );

  // Data sources

  // Core
  sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  // navigator
  sl.registerLazySingleton(
    () => NavigatorManager(),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
