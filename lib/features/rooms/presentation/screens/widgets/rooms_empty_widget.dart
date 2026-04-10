import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

class RoomsEmptyWidget extends StatelessWidget {
  const RoomsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// 🔹 Icon
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.meeting_room_outlined,
                size: 48.sp,
                color: kPrimaryColor,
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Title
            Text(
              "No Rooms Available",
              style: Styles.textStyle18,
            ),

            SizedBox(height: 8.h),

            /// 🔹 Subtitle
            Text(
              "There are no meeting rooms to display right now.\nPull down to refresh.",
              textAlign: TextAlign.center,
              style: Styles.textStyle12.copyWith(
                color: kSubTitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}