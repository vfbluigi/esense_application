import 'package:esense_application/screens/ingame/ingame_screen.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
            ),
        ),
      ),
      child: const Text(
        'START GAME',
        ),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder:(context) => const InGameScreen()),
        );
      },      
    );
  }
}