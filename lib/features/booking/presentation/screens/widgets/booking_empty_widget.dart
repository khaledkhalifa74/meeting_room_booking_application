import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking_application/core/theming/colors.dart';
import 'package:meeting_room_booking_application/core/theming/styles.dart';

class BookingsEmptyWidget extends StatelessWidget {
  const BookingsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 72.r,
            color: kSubTitleColor,
          ),
          SizedBox(height: 16.h),
          Text("No Bookings Yet", style: Styles.textStyle18),
          SizedBox(height: 8.h),
          Text(
            "This room has no reservations.\nBe the first to book it!",
            textAlign: TextAlign.center,
            style: Styles.textStyle14,
          ),
        ],
      ),
    );
  }
}