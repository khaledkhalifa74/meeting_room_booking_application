import 'package:flutter/material.dart';
import 'package:meeting_room_booking_application/features/booking/data/models/booking_model.dart';

import 'booking_card.dart';
import 'booking_empty_widget.dart';
import 'booking_skeleton_card.dart';

class BookingsListView extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final List<BookingModel> bookings;
  final Future<void> Function() onRefresh;

  const BookingsListView({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.bookings,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (isLoading) {
      return ListView.builder(
        itemCount: 4,
        itemBuilder: (_, _) => const BookingSkeletonCard(),
      );
    }

    // Empty state
    if (bookings.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 60),
            BookingsEmptyWidget(),
          ],
        ),
      );
    }

    // Populated state
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return BookingCard(
            booking: bookings[index],
          );
        },
      ),
    );
  }
}