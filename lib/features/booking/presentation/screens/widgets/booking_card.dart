import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking_application/core/theming/colors.dart';
import 'package:meeting_room_booking_application/core/theming/styles.dart';
import 'package:meeting_room_booking_application/features/booking/data/models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            // ── Avatar ───────────────────────────────────────────────────────
            CircleAvatar(
              radius: 22.r,
              backgroundColor: kPrimaryColor.withValues(alpha: 0.12),
              child: Text(
                booking.userName.isNotEmpty
                    ? booking.userName[0].toUpperCase()
                    : "?",
                style: Styles.textStyle16.copyWith(color: kPrimaryColor),
              ),
            ),

            SizedBox(width: 12.w),

            // ── Name & Date ───────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.userName, style: Styles.textStyle16),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 13.r,
                        color: kSubTitleColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(booking.date, style: Styles.textStyle12),
                    ],
                  ),
                ],
              ),
            ),

            // ── Time badge ───────────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "${booking.startTime.substring(0, 5)} - ${booking.endTime.substring(0, 5)}",
                style: Styles.textStyle12.copyWith(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}