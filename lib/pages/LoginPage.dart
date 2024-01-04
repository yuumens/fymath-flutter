// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code, no_leading_underscores_for_local_identifiers, unused_element, unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fymath/controllers/api_controller.dart';
import 'package:fymath/pages/ForgotPassword.dart';
import 'package:get/get.dart';
import 'package:fymath/pages/HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  bool playAreas = false;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordRetypeTextController =
      TextEditingController();
  final ApiController _apiController = Get.find();

  void _handleSignIn() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.red);
      return;
    }

    final loginSuccessful = await _apiController.signIn(email, password);

    if (loginSuccessful) {
      Get.offAndToNamed('/home');

      Get.snackbar("Success", "Logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.green);
    } else {
      Get.snackbar("Error", "Failed to log in. Check your email and password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.red);
    }
  }

  void _handleSignUp() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;
    final enterPassword = passwordRetypeTextController.text;

    if (email.isEmpty || password.isEmpty || enterPassword.isEmpty) {
      Get.snackbar("Error", "Email, password, and retype password are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.red);
      return;
    }

    if (password != enterPassword) {
      Get.snackbar("Error", "Password and Retype Password is Not Match",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.red);
      return;
    }

    final signUpSuccessful = await _apiController.signUp(email, password);

    if (signUpSuccessful) {
      Get.snackbar("Success", "Account has been created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.green);
    } else {
      Get.snackbar("Error", "Failed to create account. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BGLogin.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 10),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 500),
                      builder: (BuildContext context, double _value, child) {
                        return Opacity(
                          opacity: _value,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: _value * 10),
                            child: child,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(),
              Expanded(
                flex: 4,
                child: playAreas == false
                    ? TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 600),
                        builder: (BuildContext context, double _value, child) {
                          return Opacity(
                            opacity: _value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Color.fromARGB(82, 161, 161, 161),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 50,
                                color: Colors.black.withOpacity(0.01),
                              ),
                            ],
                          ),
                          // *************************************************************************
                          // ******************************Login*************************************
                          // *************************************************************************
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 310,
                                    child: TextField(
                                      controller: emailTextController,
                                      showCursor: true,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        hintText: "Username or E-mail",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        prefixIcon: Icon(
                                          Icons.perm_identity_sharp,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepPurpleAccent,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: 310,
                                child: TextField(
                                  controller: passwordTextController,
                                  showCursor: true,
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                    hintText: "Password",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: Icon(
                                      Icons.vpn_key_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: value,
                                      onChanged: (value) {
                                        setState(() {
                                          this.value = value!;
                                        });
                                      },
                                      activeColor: Colors.deepPurple[900],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    Text(
                                      "Remember Me",
                                      style: TextStyle(
                                          color: Colors.deepPurple[900],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      (ForgotPassword())),
                                            );
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                color: Colors.deepPurple[900],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    _handleSignIn();
                                  },
                                  height: 45,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 120),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.deepPurpleAccent,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 270,
                                height: 45,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (playAreas == false) {
                                        playAreas = true;
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Create account",
                                    style: TextStyle(
                                        color: Colors.deepPurple[900],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                    // *************************************************************************
                    // ******************************Signup*************************************
                    // *************************************************************************
                    : TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInQuart,
                        builder: (BuildContext context, double _value, child) {
                          return Opacity(
                            opacity: _value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Color.fromARGB(84, 161, 161, 161),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 50,
                                color: Colors.black.withOpacity(0.01),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20),
                                    child: Text(
                                      "Signup",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 310,
                                    child: TextField(
                                      controller: emailTextController,
                                      showCursor: true,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        hintText: "Username or E-mail",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        prefixIcon: Icon(
                                          Icons.perm_identity_sharp,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepPurpleAccent,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: 310,
                                child: TextField(
                                  controller: passwordTextController,
                                  obscureText: true,
                                  showCursor: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                    hintText: "12345",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: Icon(
                                      Icons.vpn_key_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: 310,
                                child: TextField(
                                  controller: passwordRetypeTextController,
                                  showCursor: true,
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: "Re-Enter Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                    hintText: "12345",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: Icon(
                                      Icons.refresh,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    _handleSignUp();
                                  },
                                  height: 45,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 120),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.deepPurpleAccent,
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 270,
                                height: 45,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (playAreas == true) {
                                        playAreas = false;
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Back to Login",
                                    style: TextStyle(
                                        color: Colors.deepPurple[900],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
