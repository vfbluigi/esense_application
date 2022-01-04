import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/oldversion/current_direction.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class PlayScreen2 extends StatefulWidget {
  const PlayScreen2({ Key? key, required this.event }) : super(key: key);

  final SensorEvent? event;

  @override
  State<PlayScreen2> createState() => _PlayScreen2State();
}

class _PlayScreen2State extends State<PlayScreen2> {
  int _counter = 0;

  final Random random = Random();

  final List<DirectionObject> directions = [
    DirectionObject(Direction.down),
    DirectionObject(Direction.up),
    DirectionObject(Direction.right),
    DirectionObject(Direction.left)
  ];

  DirectionObject currentGivenDirection = DirectionObject(Direction.empty);

  Direction currentSensorDirection = Direction.empty;

  void _setNewGivenDirection() {
    setState(() {
      int randomIndex = random.nextInt(3);
      currentGivenDirection = directions[randomIndex];
    });
  }

  void _evaluateSensorDirection() {

    bool loop = true;

    double x = 0;
    double z = 0;

    var newDirection = Direction.empty;

    while(loop) {
      if(widget.event != null) {
        x = widget.event!.gyro![0].toDouble();
        z = widget.event!.gyro![2].toDouble();
      }

      Direction newDirection = Direction.empty;
      if (x > 5000) {
        newDirection = Direction.right;
        loop = false;
      } else if (x < -5000) {
        newDirection = Direction.left;
        loop = false;
      } else if (z > 5000) {
        newDirection = Direction.down;
        loop = false;
      } else if (z < -5000) {
        newDirection = Direction.up;
        loop = false;
      }
    }

    setState(() {
      currentSensorDirection = newDirection;
    });
  }

  void _incrementCounter() {
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Score(
            counter: _counter,
          ),
          const SizedBox(
            height: 100.0,
          ),
          ElevatedButton(onPressed: () {
            _evaluateSensorDirection();
            _setNewGivenDirection();
          }, 
          child: Text('Test')),
          Row(
            children: [
              DirectionText(direction: currentGivenDirection),
              Text(currentSensorDirection.toShortString()),
            ],
          ),
        ],
      ),
    );
  }
}