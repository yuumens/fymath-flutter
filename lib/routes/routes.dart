// routes.dart
import 'package:fymath/pages/HomePage.dart';
import 'package:fymath/pages/LoginPage.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class Routes {
  static const LOGIN = '/login';
  static const HOME = '/home';
}

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
  ];
}
