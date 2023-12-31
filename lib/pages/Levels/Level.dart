// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fymath/pages/HomePage.dart';
import 'package:fymath/pages/utils/my_button.dart';
import 'package:fymath/pages/utils/result_massage.dart';
import 'package:fymath/models/Data.dart';
import 'package:provider/provider.dart';

class Level extends StatefulWidget {
  final MathLevel initialLevel;
  final int initialPoints;

  const Level({
    Key? key,
    required this.initialLevel,
    required this.initialPoints,
  }) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
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

  late MathLevel currentLevel;
  int points = 0;

  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '-',
    '0'
  ];

  int numberA = 1;
  int numberB = 1;
  int numberC = 1;
  int numberD = 1;
  String userAnswer = '';
  MathOperator currentOperator = MathOperator.addition;
  int elapsedSeconds = 0;

  var randomNumber = Random();

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (button == '-') {
        if (!userAnswer.startsWith('-') && userAnswer.isEmpty) {
          userAnswer += '-';
        }
      } else if (userAnswer.length < 4) {
        userAnswer += button;
      }
    });
  }

  void checkResult() {
    int correctResult = 0;

    if (currentLevel.level == 1) {
      if (currentOperator == MathOperator.addition) {
        correctResult = numberA + numberB;
      } else if (currentOperator == MathOperator.subtraction) {
        if (numberA < numberB) {
          correctResult = numberB - numberA;
        } else {
          correctResult = numberA - numberB;
        }
      }
    } else if (currentLevel.level == 2) {
      if (currentOperator == MathOperator.addition) {
        correctResult = numberA + numberB;
      } else if (currentOperator == MathOperator.subtraction) {
        correctResult = numberA - numberB;
      } else if (currentOperator == MathOperator.multiplication) {
        correctResult = numberA * numberB;
      } else if (currentOperator == MathOperator.division) {
        correctResult =
            (numberA ~/ numberB).round(); // Use ~/ for integer division
      }
    } else if (currentLevel.level == 3) {
      if (currentOperator == MathOperator.addition) {
        correctResult = numberA + numberB + numberC;
      } else if (currentOperator == MathOperator.subtraction) {
        correctResult = numberA - numberB - numberC;
      } else if (currentOperator == MathOperator.multiplication) {
        correctResult = numberA * numberB * numberC;
      } else if (currentOperator == MathOperator.division) {
        correctResult = (numberA / numberB / numberC).round();
      }
    } else if (currentLevel.level == 4) {
      if (currentOperator == MathOperator.addition) {
        correctResult = numberA + numberB + numberC + numberD;
      } else if (currentOperator == MathOperator.subtraction) {
        correctResult = numberA - numberB - numberC - numberD;
      } else if (currentOperator == MathOperator.multiplication) {
        correctResult = numberA * numberB * numberC * numberD;
      } else if (currentOperator == MathOperator.division) {
        correctResult = (numberA / numberB / numberC / numberD).round();
      }
    }

    if (correctResult == int.parse(userAnswer) &&
        currentLevel.level == 4 &&
        points == 9) {
      currentLevel.stopTimer();

      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message:
                'Finished with the time of: ${currentLevel.totalElapsedTime}',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icons.arrow_forward,
          );
        },
      );
    } else if (correctResult == int.parse(userAnswer)) {
      currentLevel.totalElapsedTime += const Duration(seconds: 1);
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Correct!',
            onTap: goToNextQuestion,
            icon: Icons.arrow_forward,
          );
        },
      );
      points++;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Sorry try again',
            onTap: goBackToQuestion,
            icon: Icons.rotate_left,
          );
        },
      );
      if (points > 0) {
        points--;
      }
    }
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });
    if (currentLevel.level == 1) {
      numberA = randomNumber.nextInt(11);
      numberB = randomNumber.nextInt(11);
    } else if (currentLevel.level == 2) {
      numberA = randomNumber.nextInt(11);
      numberB = 0;
      while (numberB == 0 || numberA % numberB != 0) {
        numberB = randomNumber.nextInt(11) + 1;
      }
    } else if (currentLevel.level == 3) {
      numberA = randomNumber.nextInt(21);
      numberB = randomNumber.nextInt(21);
      numberC = randomNumber.nextInt(21);

      List<MathOperator> operators = [
        currentLevel.operator1,
        currentLevel.operator2
      ];
      operators.shuffle();

      currentOperator = operators[0];
    } else if (currentLevel.level == 4) {
      numberA = randomNumber.nextInt(51);
      numberB = randomNumber.nextInt(51);
      numberC = randomNumber.nextInt(51);
      numberD = randomNumber.nextInt(51);

      //Randomly shuffle the operators
      List<MathOperator> operators = [
        currentLevel.operator1,
        currentLevel.operator2
      ];
      operators.shuffle();

      currentOperator = operators[0];
    }

    if (currentLevel.allowNegative && randomNumber.nextBool()) {
      numberA *= -1;
    }

    currentOperator = randomNumber.nextBool()
        ? currentLevel.operator1
        : currentLevel.operator2;

    if (points >= currentLevel.requiredPoints) {
      if (currentLevel.level < 4) {
        currentLevel = currentLevel.level == 1
            ? normalLevel
            : currentLevel.level == 2
                ? hardLevel
                : superLevel;
      }
      points = 0;
    }
  }

  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    currentLevel = easyLevel;
    currentLevel.startTimer();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedSeconds++; // Increment elapsed seconds every second
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          Container(
            width: 1000,
            height: 200,
            color: Colors.deepPurple,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Level ${currentLevel.level}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Motley",
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Points: $points",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Motley",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Time: $elapsedSeconds s",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Motley",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getEquationText(currentLevel.level),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white), // Replace with your style
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white), // Replace with your style
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getOperatorString() {
    if (currentOperator == MathOperator.addition) {
      return '+';
    } else if (currentOperator == MathOperator.subtraction) {
      return '-';
    } else if (currentOperator == MathOperator.multiplication) {
      return 'x';
    } else if (currentOperator == MathOperator.division) {
      return '÷';
    } else {
      return '';
    }
  }

  String getEquationText(int level) {
    if (level == 1 || level == 2) {
      return '$numberA ${getOperatorString()} $numberB = ';
    } else if (level == 3) {
      return '$numberA ${getOperatorString()} $numberB ${getOperatorString()} $numberC = ';
    } else if (level == 4) {
      return '$numberA ${getOperatorString()} $numberB ${getOperatorString()} $numberC ${getOperatorString()} $numberD = ';
    } else {
      return '';
    }
  }
}
