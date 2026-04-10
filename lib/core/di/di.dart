import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meeting_room_booking_application/core/api_client/api_service.dart';
import '../../features/rooms/data/datasource/rooms_remote_ds.dart';
import '../../features/rooms/data/repo/rooms_repo.dart';
import '../../features/rooms/presentation/manager/rooms_cubit/rooms_cubit.dart';

final di = GetIt.instance;

Future<void> initDi() async {

  /// 🔹 External
  di.registerLazySingleton<Dio>(() => Dio());

  /// 🔹 Core
  di.registerLazySingleton<ApiService>(
        () => ApiService(di<Dio>()),
  );

  /// 🔹 DataSource
  di.registerLazySingleton<RoomsRemoteDataSource>(
        () => RoomsRemoteDataSource(di<ApiService>()),
  );

  /// 🔹 Repo
  di.registerLazySingleton<RoomsRepo>(
        () => RoomsRepo(di<RoomsRemoteDataSource>()),
  );

  /// 🔹 Cubit
  di.registerFactory<RoomsCubit>(
        () => RoomsCubit(di<RoomsRepo>()),
  );
}