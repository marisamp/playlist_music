import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playlist_music/app/core/app_style/app_colors.dart';
import 'package:playlist_music/app/core/app_style/app_text.dart';
import 'package:playlist_music/app/core/constant.dart';
import 'package:playlist_music/app/modules/splash/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstant.defaulthoriPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 250.h),
              Container(
                width: AppConstant.imgWLogoSize,
                height: AppConstant.imgWLogoSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstant.logoRadius),
                  image: DecorationImage(
                    image: AssetImage(AppConstant.logoApp),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AppText.title(AppConstant.appName),
              AppText.des(AppConstant.appDesc),
              Spacer(),
              CircularProgressIndicator(color: AppColors.whiteColor),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
