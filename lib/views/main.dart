// main.dart
import 'package:flutter/material.dart';
import 'package:fymath/routes/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fymath Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
