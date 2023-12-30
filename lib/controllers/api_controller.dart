// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('658f0d832d6677ae2ec9');

final account = Account(client);

class ApiController extends GetxController {
  RxString userIdToken = ''.obs;

  Future<bool> signUp(String email, String password) async {
    try {
      final uniqueUserId = ID.unique();
      final response = await account.create(
        userId: uniqueUserId,
        email: email,
        password: password,
      );
      final registrationSuccess = response != null;
      if (registrationSuccess) {
        userIdToken.value = response.$id;
        print('User registered successfully');
      }
      return registrationSuccess;
    } catch (e) {
      print('Error during registration: $e');
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );

      final userIdFromPreferences = response.userId != null;

      if (userIdFromPreferences) {
        account.get();
        userIdToken.value = response.userId;
        Get.offAllNamed('/home');
        print('User signed in successfully');
      }
      return userIdFromPreferences;
    } catch (e) {
      print('Error during sign in: $e');
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      Future result = account.deleteSession(sessionId: 'current');
      result.then((responses) => {
            userIdToken.value = '',
            Get.snackbar("Success", "Log Out Success",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.green),
            Get.offAllNamed('/login'),
            print('User signed out successfully')
          });
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
}
