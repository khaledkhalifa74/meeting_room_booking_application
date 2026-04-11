import '../../features/rooms/data/data_source/rooms_remote_ds.dart';
import '../../features/rooms/data/repos/rooms_repo.dart';
import '../../features/rooms/presentation/manager/rooms_cubit/rooms_cubit.dart';
import 'di.dart';

void initRoomsDi() {
  /// DataSource
  di.registerLazySingleton<RoomsRemoteDataSource>(
        () => RoomsRemoteDataSource(di()),
  );

  /// Repo
  di.registerLazySingleton<RoomsRepo>(
        () => RoomsRepo(di()),
  );

  /// Cubit
  di.registerFactory<RoomsCubit>(
        () => RoomsCubit(di()),
  );
}