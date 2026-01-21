import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstant {
  // --- API Endpoint ---
  static const String baseUrl = 'https://itunes.apple.com';
  static const String search = '/search';

  // --- Image Paths  ---
  static const String logoApp = 'assets/icon/logo_app.png';

  // --- ค่าคงที่ต่างๆในแอป ---
  static double get defaulthoriPadding => 20.w;
  static double get defaultveriPadding => 10.h;
  static double get cardRadius => 20.r;
  static double get logoRadius => 50.r;
  static double get imgWLogoSize => 120.w;
  static double get imgHLogoSize => 120.h;
  static double get imgWSize => 50.w;
  static double get imgHSize => 50.h;
  static double get iconsize => 30.sp;
  static double get iconLoadingsize => 80.sp;

  // --- ข้อความที่ใช้บ่อย ---
  static const String fontFamily = 'Mitr';
  static const String appName = 'MUSIC STUDIO';
  static const String appDesc = 'A simple music playlist viewer.';
  static const String loadingCheck = 'Checking...';
  static const String loadingfalse = 'Try Again';
  static const String nodata = 'No Information';
  static const String success = 'Success';
  static const String errorMsg = 'Error';
  static const String errorMsgMusic =
      'There are no samples of this song available to listen to.';
  static const String errorMsgGeneral =
      'Something went wrong. Please try again later.';
  static const String oktext = 'OK';
  static const String canceltext = 'Cancel';
  static const String pullToRefresh = 'Pull down to refresh';
  static const String releaseToRefresh = 'Release to refresh';
  static const String pullUpToLoad = 'Pull up to load more';
  static const String releaseToLoad = 'Release to load more';
  static const String loading = 'Loading...';
  static const String noMoreData = '--- No more Song From Perses ---';
  static const String loadFailed = 'Load failed. Please try again.';
  static const String notsupport = 'This app is optimized for mobile only.';
}
