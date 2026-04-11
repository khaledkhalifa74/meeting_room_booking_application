import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meeting_room_booking_application/core/api_client/api_service.dart';
import 'rooms_di.dart';
import 'booking_di.dart';

final di = GetIt.instance;

Future<void> initDi() async {
  /// 🔹 External
  di.registerLazySingleton<Dio>(() => Dio());

  /// 🔹 Core services
  di.registerLazySingleton<ApiService>(
        () => ApiService(di<Dio>()),
  );

  /// 🔹 Feature DI
  initRoomsDi();
  initBookingDi();
}