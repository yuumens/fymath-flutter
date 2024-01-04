// ignore_for_file: must_be_immutable, file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fymath/controllers/api_controller.dart';
import 'package:fymath/pages/Levels/Level.dart';
import 'package:get/get.dart';
import 'package:fymath/models/Data.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MathLevel currentLevel;
  late int points = 0;
  final audioPlayer = AudioPlayer();
  final ApiController appwrite = Get.put(ApiController());
  bool isMusicOn = true;

  // Initialize easyLevel before using it
  @override
  void initState() {
    super.initState();
    currentLevel = easyLevel;
    points = 0;
    playBackgroundMusic();
  }

  // void playBackgroundMusic() async {
  //   await audioPlayer.play(AssetSource('music/bgms.mp3'));
  //   audioPlayer.setVolume(1);
  // }

  void playBackgroundMusic() async {
    if (isMusicOn) {
      await audioPlayer.play(AssetSource('music/bgms.mp3'));
    } else {
      audioPlayer.stop();
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1000,
            height: 160,
            color: Colors.deepPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(Icons.leaderboard_rounded),
                  onPressed: () {
                    _showLeaderBoard();
                  },
                  color: Colors.white,
                ),
                IconButton(
                  icon: const Icon(Icons.settings), // Add settings icon
                  onPressed: () {
                    _showSettingsDialog();
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Hi ${appwrite.username}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Motley",
                          ),
                        ),
                        Text(
                          "Level ${currentLevel.level}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Motley",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Points: $points",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Motley",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    _apiController.signOut();
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
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
          const SizedBox(height: 20),
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
          const SizedBox(
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
              backgroundColor: Colors.deepPurple,
              elevation: 4, // Add elevation for 3D effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Start',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Motley",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person),
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

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontFamily: "Motley",
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width * 0.200,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Music',
                        style: TextStyle(
                          fontFamily: "Motley",
                        ),
                      ),
                      trailing: Switch(
                        value: isMusicOn,
                        onChanged: (value) {
                          setState(() {
                            isMusicOn = value;
                            playBackgroundMusic();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: "Motley",
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLeaderBoard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'LeaderBoard',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontFamily: "Motley",
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your LeaderBoard Content Here',
                          textAlign: TextAlign.center,
                        ),

                        // Add other leaderboard content here
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
