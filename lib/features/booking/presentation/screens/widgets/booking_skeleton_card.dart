import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:meeting_room_booking_application/features/booking/data/models/booking_model.dart';
import 'package:meeting_room_booking_application/features/booking/presentation/screens/widgets/booking_card.dart';

class BookingSkeletonCard extends StatelessWidget {
  const BookingSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: BookingCard(
        booking: BookingModel(
          id: 0,
          roomId: 0,
          startTime: '10:00:00',
          endTime: '12:00:00',
          userName: 'Loading...',
          date: '2026-01-01',
        ),
      ),
    );
  }
}