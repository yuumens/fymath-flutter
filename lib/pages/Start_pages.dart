// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, sort_child_properties_last, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'loginPage.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashScreen.jpg'),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [Colors.purple, Color(0xff4a148c)],
          // ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: TweenAnimationBuilder(
                child: Text(
                  "Fymath",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      height: 1.0,
                      fontFamily: "Motley"),
                ),
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double _value, child) {
                  return Opacity(
                    opacity: _value,
                    child: Padding(
                      padding: EdgeInsets.only(top: _value * 20),
                      child: child,
                    ),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 60,
            // ),
            // Container(
            //   width: 300,
            //   height: 300,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/40.png'),
            //         fit: BoxFit.fill),
            //   ),
            // ),
            Spacer(),
            TweenAnimationBuilder(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (LoginScreen())),
                      );
                    },
                    height: 45,
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 500),
              builder: (BuildContext context, double _value, child) {
                return Opacity(
                  opacity: _value,
                  child: Padding(
                    padding: EdgeInsets.only(top: _value * 30),
                    child: child,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
