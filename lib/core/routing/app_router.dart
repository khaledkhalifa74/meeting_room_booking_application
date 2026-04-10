import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking_application/core/routing/routes.dart';
import 'package:meeting_room_booking_application/core/di/di.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/rooms/presentation/screens/rooms_screen.dart';
import '../../features/rooms/presentation/manager/rooms_cubit/rooms_cubit.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.roomsScreen,
    routes: [

      /// 🔹 Rooms Screen
      GoRoute(
        path: Routes.roomsScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => di<RoomsCubit>()..getRooms(),
          child: const RoomsScreen(),
        ),
      ),

      /// 🔹 Booking Screen
      GoRoute(
        path: Routes.bookingScreen,
        builder: (context, state) => const BookingScreen(),
      ),
    ],
  );
}