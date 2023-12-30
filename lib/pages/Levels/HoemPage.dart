import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fymath/pages/Const.dart';
import 'package:fymath/pages/utils/my_button.dart';
import 'package:fymath/pages/utils/result_massage.dart';

enum MathOperator { addition, subtraction, multiplication, division }

class MathLevel {
  final int level;
  final MathOperator operator1;
  final MathOperator operator2;
  final bool allowNegative;
  final int requiredPoints;

  MathLevel({
    required this.level,
    required this.operator1,
    required this.operator2,
    required this.allowNegative,
    required this.requiredPoints,
  });
}

class HoemPage extends StatefulWidget {
  const HoemPage({Key? key}) : super(key: key);

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  final MathLevel easyLevel = MathLevel(
    level: 1,
    operator1: MathOperator.addition,
    operator2: MathOperator.subtraction,
    allowNegative: false,
    requiredPoints: 1,
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
  late String currentQuestion; // Perubahan disini

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
      } else if (userAnswer.length < 3) {
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

    if (correctResult == int.parse(userAnswer)) {
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Correct!',
            onTap: goToNextcurretQuestion,
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
            onTap: goBackTocurretQuestion,
            icon: Icons.rotate_left,
          );
        },
      );
      if (points > 0) {
        points--;
      }
    }
  }

  void goToNextcurretQuestion() {
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });

    generateRandomcurretQuestion();
  }

  void goBackTocurretQuestion() {
    Navigator.of(context).pop();
  }

  void generateRandomcurretQuestion() {
    userAnswer = '';

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
    } else if (currentLevel.level == 4) {
      numberA = randomNumber.nextInt(51);
      numberB = randomNumber.nextInt(51);
      numberC = randomNumber.nextInt(51);
      numberD = randomNumber.nextInt(51);
    }

    // Reset operator
    currentOperator = currentLevel.operator1;
    if (randomNumber.nextBool()) {
      currentOperator = currentLevel.operator2;
    }

    // Acak urutan operator
    List<MathOperator> operators = [
      MathOperator.addition,
      MathOperator.subtraction,
      MathOperator.multiplication,
      MathOperator.division
    ];
    operators.shuffle();

    currentQuestion = '';
    if (operators[0] == MathOperator.addition) {
      currentQuestion = '$numberA + $numberB';
    } else if (operators[0] == MathOperator.subtraction) {
      currentQuestion = '$numberA - $numberB';
    } else if (operators[0] == MathOperator.multiplication) {
      currentQuestion = '$numberA x $numberB';
    } else if (operators[0] == MathOperator.division) {
      currentQuestion = '$numberA / $numberB';
    }

    if (operators[1] == MathOperator.addition) {
      currentQuestion = '$currentQuestion + $numberC';
    } else if (operators[1] == MathOperator.subtraction) {
      currentQuestion = '$currentQuestion - $numberC';
    } else if (operators[1] == MathOperator.multiplication) {
      currentQuestion = '$currentQuestion x $numberC';
    } else if (operators[1] == MathOperator.division) {
      currentQuestion = '$currentQuestion / $numberC';
    }

    print('Generated currentQuestion: $currentQuestion');
  }

  @override
  void initState() {
    super.initState();
    currentLevel = easyLevel;
    generateRandomcurretQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
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
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$currentQuestion = ',
                      style: whiteTextStyle,
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
                          style: whiteTextStyle,
                        ),
                      ),
                    )
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
}
