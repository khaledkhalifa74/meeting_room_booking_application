import '../../features/booking/data/data_source/booking_remote_ds.dart';
import '../../features/booking/data/repos/booking_repo.dart';
import '../../features/booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'di.dart';

void initBookingDi() {
  /// DataSource
  di.registerLazySingleton<BookingRemoteDataSource>(
        () => BookingRemoteDataSource(di()),
  );

  /// Repo
  di.registerLazySingleton<BookingRepo>(
        () => BookingRepo(di()),
  );

  /// Cubit
  di.registerFactory<BookingCubit>(
        () => BookingCubit(di()),
  );
}