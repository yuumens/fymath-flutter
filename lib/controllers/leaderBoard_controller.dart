import 'package:flutter/material.dart';
import 'package:fymath/models/Data.dart';

class leaderBoard extends ChangeNotifier {
  List<MathLevel> _todos = [];
  List<MathLevel> get todos => _todos;
}
