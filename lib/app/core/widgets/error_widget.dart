// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playlist_music/app/core/app_style/app_colors.dart';
import 'package:playlist_music/app/core/app_style/app_text.dart';
import 'package:playlist_music/app/core/constant.dart';

void showErrorDialog(String message) {
  Get.defaultDialog(
    title: AppConstant.errorMsg,
    titleStyle:
        TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.bold),
    middleText: message,
    middleTextStyle: const TextStyle(color: Colors.black87),
    textConfirm: AppConstant.oktext,
    confirmTextColor: AppColors.whiteColor,
    buttonColor: AppColors.okColor,
    backgroundColor: AppColors.whiteColor,
    onConfirm: () => Get.back(),
    contentPadding: const EdgeInsets.all(20),
  );
}

class NoData extends StatelessWidget {
  final void Function()? onPressed;
  const NoData({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppConstant.imgWLogoSize,
            height: AppConstant.imgWLogoSize,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppConstant.logoRadius),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppConstant.defaulthoriPadding),
              child: Image.asset(
                AppConstant.logoApp,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          AppText(
            AppConstant.nodata,
            textAlign: TextAlign.center,
            fontSize: 20.sp,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AppColors.okColor,
              ),
              foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: AppConstant.defaulthoriPadding,
                  vertical: AppConstant.defaultveriPadding,
                ),
              ),
            ),
            child: AppText.body(
              AppConstant.loadingfalse,
              color: AppColors.whiteColor,
            ),
          )
        ],
      ),
    );
  }
}

class NotSupportedView extends StatelessWidget {
  const NotSupportedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120.w,
              height: 200.h,
              child: Image.asset(
                AppConstant.logoApp,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10.h),
            AppText(
              AppConstant.appName,
              textAlign: TextAlign.center,
              fontSize: 12.sp,
              color: AppColors.whiteColor,
            ),
            SizedBox(height: 10.h),
            AppText(
              AppConstant.notsupport,
              textAlign: TextAlign.center,
              fontSize: 10.sp,
              color: AppColors.whiteColor,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
