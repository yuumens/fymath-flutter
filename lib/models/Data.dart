import 'dart:async';
import 'package:flutter/material.dart';

enum MathOperator { addition, subtraction, multiplication, division }

class MathLevel {
  final int level;
  final MathOperator operator1;
  final MathOperator operator2;
  final bool allowNegative;
  final int requiredPoints;
  Duration totalElapsedTime = Duration.zero;
  late Timer timer;
  late ValueNotifier<Duration> elapsedTimeNotifier;


  MathLevel({
    required this.level,
    required this.operator1,
    required this.operator2,
    required this.allowNegative,
    required this.requiredPoints,
  }) {
    elapsedTimeNotifier = ValueNotifier<Duration>(totalElapsedTime);
    startTimer();
  }
    void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      totalElapsedTime += Duration(seconds: 1);
      elapsedTimeNotifier.value = totalElapsedTime;
    });
  }
    void stopTimer() {
    timer.cancel();
  }
}