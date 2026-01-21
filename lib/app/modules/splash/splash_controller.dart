

import 'package:get/get.dart';
import 'package:playlist_music/app/core/route/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startApp();
  }

  void startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(AppRoutes.home); 
  }
}