import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

class RoomsErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RoomsErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// 🔴 Error Icon
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48.sp,
                color: Colors.red,
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Title
            Text(
              "Something went wrong",
              style: Styles.textStyle18,
            ),

            SizedBox(height: 8.h),

            /// 🔹 Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: Styles.textStyle12.copyWith(
                color: kSubTitleColor,
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔁 Retry Button
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}