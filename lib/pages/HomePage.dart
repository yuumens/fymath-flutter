import 'package:flutter/material.dart';
import 'package:fymath/pages/Levels/Level.dart';
import 'package:get/get.dart';

final MathLevel easyLevel = MathLevel(
  level: 1,
  operator1: MathOperator.addition,
  operator2: MathOperator.subtraction,
  allowNegative: false,
  requiredPoints: 10,
);
final MathLevel normalLevel = MathLevel(
  level: 2,
  operator1: MathOperator.multiplication,
  operator2: MathOperator.division,
  allowNegative: false,
  requiredPoints: 10,
);
final MathLevel hardLevel = MathLevel(
  level: 3,
  operator1: MathOperator.addition,
  operator2: MathOperator.subtraction,
  allowNegative: false,
  requiredPoints: 10,
);
final MathLevel superLevel = MathLevel(
  level: 4,
  operator1: MathOperator.addition,
  operator2: MathOperator.subtraction,
  allowNegative: true,
  requiredPoints: 10,
);

class HomePage extends StatelessWidget {
  late MathLevel currentLevel;
  late int points = 0;

  HomePage() {
    // Initialize easyLevel before using it
    currentLevel = easyLevel;
    points = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1000,
            height: 160,
            color: Colors.deepPurple,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Level ${currentLevel.level}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Motley",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Points: $points",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Motley",
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox(
                  'Level 1 \nStatus : ${currentLevel.level == 1 ? (points >= currentLevel.requiredPoints ? "Complete" : "Not Complete") : ""}',
                  Colors.red),
              _buildBox(
                  'Level 2 \nStatus : ${currentLevel.level == 2 ? (points >= currentLevel.requiredPoints ? "Complete" : "Not Complete") : ""}',
                  Colors.blue),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox(
                  'Level 3 \nStatus : ${currentLevel.level == 3 ? (points >= currentLevel.requiredPoints ? "Complete" : "Not Complete") : ""}',
                  Colors.green),
              _buildBox(
                  'Level 4 \nStatus : ${currentLevel.level == 4 ? (points >= currentLevel.requiredPoints ? "Complete" : "Not Complete") : ""}',
                  Colors.orange),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(Level(
                initialLevel: currentLevel,
                initialPoints: points,
              ));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              elevation: 4, // Add elevation for 3D effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              'Start',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Motley",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox(String text, Color color) {
    return Container(
      width: 150,
      height: 150,
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Motley",
          ),
        ),
      ),
    );
  }
}
