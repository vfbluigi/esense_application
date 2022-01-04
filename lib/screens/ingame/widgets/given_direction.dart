import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class DirectionText extends StatelessWidget {
  const DirectionText({ Key? key, this.caption = '', required this.direction, this.color = Colors.blue }) : super(key: key);

  final DirectionObject direction;
  final String caption;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Text(
            caption,
            style: const TextStyle(
              fontSize: 40.0,
              color: Colors.orange,
            ),
          ),
          Text(
            '$direction',
            style: TextStyle(
                fontSize: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}