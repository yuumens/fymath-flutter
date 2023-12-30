// main.dart
import 'package:flutter/material.dart';
import 'package:fymath/controllers/api_controller.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import 'package:appwrite/appwrite.dart';

void main() async {
  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('658f0d832d6677ae2ec9')
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Your App Title',
    initialRoute: AppRoutes.START,
    getPages: AppPages.routes,
  ));

  Get.put(ApiController());
}
