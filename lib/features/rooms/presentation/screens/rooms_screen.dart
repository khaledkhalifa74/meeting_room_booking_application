import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/screens/widgets/room_card.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/screens/widgets/room_skeleton_card.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/screens/widgets/rooms_empty_widget.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/screens/widgets/rooms_error_widget.dart';
import '../../../../core/routing/routes.dart';
import '../manager/rooms_cubit/rooms_cubit.dart';
import '../manager/rooms_cubit/rooms_state.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<RoomsCubit>().getRooms();
  }

  Future<void> _onRefresh() async {
    await context.read<RoomsCubit>().getRooms();
  }

  String getErrorMessage(String message) {
    if (message.contains("network")) {
      return "Check your internet connection";
    }
    return message;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting Rooms"),
      ),
      body: BlocBuilder<RoomsCubit, RoomsState>(
        builder: (context, state) {

          if (state is RoomsError) {
            return RoomsErrorWidget(
              message: getErrorMessage(state.message),
              onRetry: _onRefresh,
            );
          }

          final isLoading = state is RoomsLoading;
          final isSuccess = state is RoomsSuccess;
          final rooms = isSuccess ? state.rooms : [];

          /// 🔹 Empty State
          if (isSuccess && rooms.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  RoomsEmptyWidget(),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: isLoading ? 4 : (state as RoomsSuccess).rooms.length,
              itemBuilder: (context, index) {

                if (isLoading) {
                  return const RoomSkeletonCard();
                }

                final room = (state as RoomsSuccess).rooms[index];

                return RoomCard(
                  room: room,
                  onBook: () {
                    context.push(
                      "${Routes.bookingScreen}?roomId=${room.id}",
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}