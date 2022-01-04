import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:flutter/material.dart';

class GameOverScreem extends StatelessWidget {
  const GameOverScreem({ Key? key, required this.score, required this.highscore }) : super(key: key);

  final int highscore;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Container(
        color: null,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/images/headache.png',
                  scale: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                      const Text(
                        'HIGH SCORE',
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.orange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$highscore',
                        style: const TextStyle(
                          fontSize: 80.0,
                          color: Colors.orange,
                        )
                      ),
                  ],
                ),
              ),
              Score(
                counter: score,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 70.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              ),
                          ),
                        ),
                        child: Text(
                          'TRY AGAIN',
                          ),
                        onPressed: () => Navigator.pop(context),   
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}