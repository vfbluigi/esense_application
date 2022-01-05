import 'package:esense_application/ingame/widgets/score.dart';
import 'package:esense_application/widgets/headache_image.dart';
import 'package:esense_application/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({ Key? key, required this.score, required this.highscore }) : super(key: key);

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
              const HeadacheImage(),
              Score(
                title: 'HIGHSCORE', 
                counter: highscore, 
                color: Colors.orange
              ),
              Score(
                title: 'SCORE',
                counter: score,
              ),
              RoundedButton(title: 'TRY AGAIN', onPressed: () => Navigator.pop(context)),
              RoundedButton(title: 'HOME', onPressed: () {
                var nav = Navigator.of(context);
                nav.pop();
                nav.pop();
              })
            ],
          ),
        ),
      ),
    );
  }
}