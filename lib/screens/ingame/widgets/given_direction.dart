import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class GivenDirectionText extends StatelessWidget {
  const GivenDirectionText({ Key? key, required this.direction }) : super(key: key);

  final DirectionObject direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        direction.directionString,
        style: const TextStyle(
            color: Colors.blue,
            fontSize: 40.0,
        ),
      )      
    );
  }
}