import 'dart:io';
import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/screens/ingame/widgets/current_direction.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:flutter/material.dart';

import 'package:esense_flutter/esense.dart';
import 'dart:async';

import '../ingame_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int _counter = 0;
  double x = 0;
  double y = 0;
  double z = 0;
  String _event = '';
  StreamSubscription? subscription;

  Random random = Random();

  var directions = [
    DirectionObject(Direction.down),
    DirectionObject(Direction.up),
    DirectionObject(Direction.right),
    DirectionObject(Direction.left)
  ];

  late DirectionObject currentGivenDirection;
  late Direction currentSensorDirection;

  void _setPosition(double a, double b, double c) {
    setState(() {
      x = a;
      y = b;
      z = c;
    });
  }

  void _setNewGivenDirection() {
    int randomIndex = random.nextInt(3);
    setState(() {
      currentGivenDirection = directions[randomIndex];
    });
  }

  void _startListenToSensorEvents() async {

    subscription = ESenseManager().sensorEvents.listen((event) {
      
      setState(() {
        _event = event.toString();
      });
      double x = event.gyro![0].toDouble();
      double y = event.gyro![1].toDouble();
      double z = event.gyro![2].toDouble();
      _setPosition(x, y, z);
      /*if (x > 5000) {
        _setNewGivenDirection();
        setState(() {
          currentSensorDirection = Direction.right;
        });
      } else if (x < -5000) {
        setState(() {
          currentSensorDirection = Direction.left;
        });
      } else if (z > 5000) {
        setState(() {
          currentSensorDirection = Direction.down;
        });
      } else if (z < -5000) {
        setState(() {
          currentSensorDirection = Direction.down;
        });
      }*/
    });
  }

  Direction _evaluateSensorDirection(double x, double y, double z) {

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

    return newDirection;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    currentGivenDirection = directions[0];
    currentSensorDirection = Direction.left;
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
          ElevatedButton(
            onPressed: () {
              _startListenToSensorEvents();
            },
            child: Text('test'),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Row(
            children: [
              GivenDirectionText(direction: currentGivenDirection),
              Text(currentSensorDirection.toShortString()),
              CurrentDirection(title:_event, x: x, y: y, z: z),
            ],
          ),
          /*
          StreamBuilder<SensorEvent>(
            stream: ESenseManager().sensorEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                sleep(const Duration(milliseconds: 500));
                double x = snapshot.data!.gyro![0].toDouble();
                double y = snapshot.data!.gyro![1].toDouble();
                double z = snapshot.data!.gyro![2].toDouble();
                Direction sensorDirection = _evaluateSensorDirection(x, y, z);

                if(sensorDirection == Direction.empty) {
                  return CurrentDirection(title: '-', x: x, y: y, z: z);
                }


                sleep(const Duration(milliseconds: 1000));
                  return CurrentDirection(title: '-', x: x, y: y, z: z);
              }

              return const Text('no value');
            },
          )*/
        ],
      ),
    );
  }
}
