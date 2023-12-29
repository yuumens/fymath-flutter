// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
// import 'routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Title',
      initialRoute: AppRoutes.START,
      getPages: AppPages.routes,
    );
  }
}
