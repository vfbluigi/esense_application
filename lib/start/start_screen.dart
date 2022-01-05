import 'package:esense_application/widgets/headache_image.dart';
import 'package:esense_application/widgets/rounded_button.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body : Column(
        children: [
          const HeadacheImage(),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: GameTitle(),
          ),
          RoundedButton(title: 'START GAME', onPressed: () => Navigator.pushNamed(context, '/streambuilder'),),
        ],
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
            'HEADACHE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 60,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )
          ),
        Text(
          'you will have it after playing',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100,
          )
        ),
      ],
      
    );
  }
}