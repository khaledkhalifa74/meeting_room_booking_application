import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking_application/core/routing/routes.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/rooms/presentation/screens/rooms_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.roomsScreen,
    routes: [
      GoRoute(
        path: Routes.roomsScreen,
        builder: (context, state) => const RoomsScreen(),
      ),

      GoRoute(
        path: Routes.bookingScreen,
       builder: (context, state) => const BookingScreen(),
      ),
    ],
  );
}