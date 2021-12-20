import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/screens/ingame/widgets/current_direction.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class PlayScreen2 extends StatelessWidget {
  PlayScreen2({ Key? key, required this.event }) : super(key: key);

  int _counter = 0;

  final SensorEvent? event;

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
    int randomIndex = random.nextInt(3);
    currentGivenDirection = directions[randomIndex];
  }

  void _evaluateSensorDirection() {

    double x = 0;
    double z = 0;
    if(event != null) {
      x = event!.gyro![0].toDouble();
      z = event!.gyro![2].toDouble();
    }

    Direction newDirection = Direction.empty;
    if (x > 5000) {
      newDirection = Direction.right;
    } else if (x < -5000) {
      newDirection = Direction.left;
    } else if (z > 5000) {
      newDirection = Direction.down;
    } else if (z < -5000) {
      newDirection = Direction.up;
    }

    currentSensorDirection = newDirection;
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
              GivenDirectionText(direction: currentGivenDirection),
              Text(currentSensorDirection.toShortString()),
            ],
          ),
        ],
      ),
    );
  }
}