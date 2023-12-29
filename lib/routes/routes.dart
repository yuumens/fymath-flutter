// app_routes.dart

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/HomePage.dart';
import '../pages/LoginPage.dart';
import '../pages/Start_pages.dart';

// part 'routes.dart';

abstract class AppRoutes {
  static const START = '/';
  static const LOGIN = '/login';
  static const HOME = '/home';
}

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.START,
      page: () => StartScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
    ),
  ];
}
