import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking_application/core/theming/colors.dart';
import 'package:meeting_room_booking_application/core/theming/styles.dart';

class BookingFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool isSubmitting;
  final VoidCallback onPickDate;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;
  final VoidCallback onSubmit;

  const BookingFormWidget({
    super.key,
    required this.nameController,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.isSubmitting,
    required this.onPickDate,
    required this.onPickStartTime,
    required this.onPickEndTime,
    required this.onSubmit,
  });

  String _formatTime(TimeOfDay t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── User Name ──────────────────────────────────────────────────
            TextField(
              controller: nameController,
              style: Styles.textStyle14.copyWith(color: kContentTextColor),
              decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: Styles.textStyle14,
                prefixIcon: Icon(Icons.person_outline, size: 20.r, color: kSubTitleColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // ── Date ──────────────────────────────────────────────────────
            _PickerTile(
              icon: Icons.calendar_month_outlined,
              label: "Date",
              value: selectedDate == null
                  ? "Select a date"
                  : selectedDate.toString().split(" ")[0],
              hasValue: selectedDate != null,
              onTap: onPickDate,
            ),

            SizedBox(height: 10.h),

            // ── Time slots ────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _PickerTile(
                    icon: Icons.access_time_outlined,
                    label: "Start",
                    value: startTime == null ? "-- : --" : _formatTime(startTime!),
                    hasValue: startTime != null,
                    onTap: onPickStartTime,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _PickerTile(
                    icon: Icons.access_time_filled_outlined,
                    label: "End",
                    value: endTime == null ? "-- : --" : _formatTime(endTime!),
                    hasValue: endTime != null,
                    onTap: onPickEndTime,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            // ── Submit ────────────────────────────────────────────────────
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  backgroundColor: kPrimaryColor,
                  foregroundColor: kWhiteColor,
                ),
                child: isSubmitting
                    ? SizedBox(
                  height: 22.r,
                  width: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: kWhiteColor,
                  ),
                )
                    : Text("Book Room", style: Styles.textStyle16.copyWith(color: kWhiteColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable picker tile ───────────────────────────────────────────────────────
class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool hasValue;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.hasValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasValue ? kPrimaryColor : kHintColor.withValues(alpha: 0.4),
            width: hasValue ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(10.r),
          color: hasValue ? kPrimaryColor.withValues(alpha: 0.06) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.r,
              color: hasValue ? kPrimaryColor : kSubTitleColor,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Styles.textStyle12),
                  Text(
                    value,
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: hasValue ? kPrimaryColor : kHintColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}