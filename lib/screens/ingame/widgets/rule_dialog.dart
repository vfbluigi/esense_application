import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class RuleDialog extends StatelessWidget {
  RuleDialog({ Key? key, required this.direction1, required this.direction2 }) : super(key: key);

  DirectionObject direction1;
  DirectionObject direction2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text(
          'RULE',
          style: TextStyle(
            fontSize: 40,
            color: Colors.orange,
          )
        )),
      content: Text(
          '$direction1 and $direction2 \nare switched',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 50,
              icon: const Icon(
                Icons.play_circle,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}