import 'package:flutter/material.dart';
import 'package:meeting_room_booking_application/features/rooms/data/models/room_model.dart';
import 'package:meeting_room_booking_application/features/rooms/presentation/screens/widgets/room_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoomSkeletonCard extends StatelessWidget {
  const RoomSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: RoomCard(
        room: RoomModel(id: 0, name: 'name', capacity: 0),
        onBook: () {},
      ),
    );
  }
}