import '../../features/rooms/data/datasource/rooms_remote_ds.dart';
import '../../features/rooms/data/repo/rooms_repo.dart';
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