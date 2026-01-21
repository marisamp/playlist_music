// lib/app/core/app_text.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import '../constant.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const AppText(
    this.text, { 
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  // title text
  factory AppText.title(String text, {Color? color}) => AppText(
        text,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.whiteColor,
      );

  // body text
  factory AppText.body(String text, {Color? color}) => AppText(
        text,
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
        color: color ?? AppColors.whiteColor,
      );

  // des text
  factory AppText.des(String text, {Color? color}) => AppText(
        text,
        fontSize: 16.sp,
        color: color ?? AppColors.whiteColor,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: AppConstant.fontFamily, 
        fontSize: fontSize ?? 14.sp,       
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
  }
}