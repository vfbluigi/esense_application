import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/screens/ingame/screens/gameover_screen.dart';
import 'package:esense_application/screens/ingame/widgets/direction_viewer.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/rule_dialog.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class ESenseScreen extends StatefulWidget {
  ESenseScreen({Key? key, required this.connection}) : super(key: key);

  ConnectionType connection;

  @override
  _ESenseScreenState createState() => _ESenseScreenState();
}

class _ESenseScreenState extends State<ESenseScreen> {
  final String _deviceStatus = '';
  bool hasSampled = false;
  SensorEvent? _event;
  bool needsValues = true;

  // the name of the eSense device to connect to -- change this to your own device.
  final String eSenseName = 'eSense-0864';

  @override
  void initState() {
    super.initState();
    _startListenToSensorEvents();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }


  StreamSubscription? subscription;
  void _startListenToSensorEvents() async {

    if(widget.connection != ConnectionType.connected) {
      return;
    }
    
    if (hasSampled) {
      subscription?.cancel();
      subscription = null;
    }
    setState(() {
      hasSampled = true;
    });


    ESenseManager().setSamplingRate(10);


    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) async {

        if (needsValues) {
          setState(() {
            _event = event;
          });
          
          _evaluateSensorDirection();
        }

    });
  }

  void _pauseListenToSensorEvents() async {
    subscription?.cancel();
  }

  @override
  void dispose() {
    _pauseListenToSensorEvents();
    ESenseManager().disconnect();
    super.dispose();
  }

  void _restart() {
    setState(() {
      currentSensorDirection = Direction.empty;
      backgroundColor = null;
      _score = 0;
      directionHandler.reset();
      needsValues = true;
    });

    _startListenToSensorEvents();
  }




  int _score = 0;
  int _highscore = 0;

  final Random random = Random();

  final DirectionHandler directionHandler = DirectionHandler();

  Direction currentSensorDirection = Direction.empty;
  MaterialColor? backgroundColor;

  bool showHelp = false;


  void _evaluateSensorDirection() async {
    double x = 0;
    double z = 0;
    if (_event != null) {
      x = _event!.gyro![0].toDouble();
      z = _event!.gyro![2].toDouble();
    }

    Direction newDirection;
    if (x > 5000) {
      newDirection = Direction.right;
    } else if (x < -5000) {
      newDirection = Direction.left;
    } else if (z > 5000) {
      newDirection = Direction.down;
    } else if (z < -5000) {
      newDirection = Direction.up;
    } else {
      newDirection = Direction.empty;
    }

    if(newDirection != Direction.empty) {

      setState(() {
        needsValues = false;
        currentSensorDirection = newDirection;
        backgroundColor = (directionHandler.givenDirection.actualDirection == currentSensorDirection) ? Colors.green : Colors.red;
      });


      await Future.delayed(const Duration(milliseconds: 1000), () {
        _compareDirections();
      });

    }
  }

  Future<void> _compareDirections() async {
    if (directionHandler.givenDirection.actualDirection == currentSensorDirection) {

      _incrementScore();

    } else {

      _pauseListenToSensorEvents();

      if (_score > _highscore) _highscore = _score;

      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder:(context) => GameOverScreem(score: _score, highscore: _highscore)),
        ModalRoute.withName('/streambuilder'))
        .then((value) {
          _restart();
        });

        return;
    }

    if(_score % 4 == 0) {
      List? changedDirections;
      setState(() { changedDirections = directionHandler.changeDirections(); });
      showDialog(context: context, barrierDismissible: false, builder: (context) => RuleDialog(direction1: changedDirections![0], direction2: changedDirections![1])).
        then((value) {
          _continuePlaying();
        });

        return;
    }

    _continuePlaying();
  }

  void _continuePlaying() {
    setState(() {
      backgroundColor = null;
      currentSensorDirection = Direction.empty;
      directionHandler.createNewGivenDirection();
      needsValues = true;
    });
  }

  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            //Text('eSense Device Status: \t$_deviceStatus'),
            //Text(_event.toString()),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Score(
                    counter: _score,
                  ),
                  SizedBox(
                    width: 400.0,
                    height: 150.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          left: 20,
                          child: DirectionText(caption: 'Given', direction: directionHandler.givenDirection)
                        ),
                        Positioned(
                          right: 20,
                          child: DirectionText(caption: 'Input', direction: DirectionObject(currentSensorDirection), color: Colors.blue)
                        ),
                      ],)
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showHelp = !showHelp;
                      });
                    }, 
                    iconSize: 50,
                    icon: Icon(showHelp ? Icons.visibility_off_outlined : Icons.visibility_outlined)) ,
                  showHelp ? DirectionViewer(directionHandler: directionHandler): Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}