import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room_booking_application/core/theming/colors.dart';

abstract class Styles {
  static TextStyle get textStyle12 => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: kSubTitleColor,
  );

  static TextStyle get textStyle14 => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: kSubTitleColor,
  );

  static TextStyle get textStyle16 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: kContentTextColor,
  );

  static TextStyle get textStyle18 => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: kDarkBlackColor,
  );

  static TextStyle get textStyle20 => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: kDarkBlackColor,
  );

  static TextStyle get textStyle22 => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: kDarkBlackColor,
  );

  static TextStyle get textStyle24 => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: kDarkBlackColor,
  );

  static TextStyle get textStyle32 => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: kDarkBlackColor,
  );
}