

import 'package:get/get.dart';
import 'package:playlist_music/app/core/route/app_routes.dart';
import 'package:playlist_music/app/modules/home/home_view.dart';
import 'package:playlist_music/app/modules/splash/splash_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashView(),
      transition: Transition.fadeIn, 
    ),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeView(),
      transition: Transition.fadeIn, 
    ),
  ];
}