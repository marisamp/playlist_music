import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playlist_music/app/core/app_style/app_colors.dart';
import 'package:playlist_music/app/core/constant.dart';
import 'package:playlist_music/app/core/route/app_pages.dart';
import 'package:playlist_music/app/core/route/app_routes.dart';
import 'package:playlist_music/app/core/widgets/error_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: AppConstant.appName,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          theme: ThemeData(
            fontFamily: AppConstant.fontFamily,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.blackColor),
          ),
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // only support mobile app
                if (constraints.maxWidth > 600) {
                  return const NotSupportedView();
                }

                return child!;
              },
            );
          },
        );
      },
    );
  }
}
