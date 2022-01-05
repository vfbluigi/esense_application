import 'dart:async';
import 'package:esense_application/ingame/models/direction.dart';
import 'package:esense_application/ingame/models/direction_handler.dart';
import 'package:esense_application/ingame/screens/gameover_screen.dart';
import 'package:esense_application/ingame/widgets/direction_display.dart';
import 'package:esense_application/ingame/widgets/compass.dart';
import 'package:esense_application/ingame/widgets/rule_dialog.dart';
import 'package:esense_application/ingame/widgets/score.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.connection}) : super(key: key);

  final ConnectionType connection;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  SensorEvent? _event;
  bool _needsValues = true;

  int _score = 0;
  int _highscore = 0;

  final DirectionHandler _directionHandler = DirectionHandler();
  Direction _currentSensorDirection = Direction.empty;

  MaterialColor? _backgroundColor;

  bool _showHelp = false;

  //Constants
  final int _stepsToNewRule = 4;

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

    ESenseManager().setSamplingRate(10);

    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) async {

        if (_needsValues) {
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




  void _evaluateSensorDirection() async {
    double x = 0;
    double z = 0;
    x = _event!.gyro![0].toDouble();
    z = _event!.gyro![2].toDouble();
  
    Direction newDirection = DirectionHandler.evaluateDirection(x, z);

    if(newDirection != Direction.empty) {

      setState(() {
        _needsValues = false;
        _currentSensorDirection = newDirection;
        _backgroundColor = (_directionHandler.givenDirection.actualDirection == _currentSensorDirection) ? Colors.green : Colors.red;
      });


      await Future.delayed(const Duration(milliseconds: 1000), () {
        _compareDirections();
      });

    }
  }

  Future<void> _compareDirections() async {
    if (_directionHandler.givenDirection.actualDirection == _currentSensorDirection) {

      setState(() {
        _score++;
      });

    } else {

      _pauseListenToSensorEvents();

      if (_score > _highscore) _highscore = _score;

      Navigator.push(
        context, 
        MaterialPageRoute(builder:(context) => GameOverScreen(score: _score, highscore: _highscore)))
        .then((value) {
          _restart();
        });

      return;
    }

    //New Rule
    if(_score % _stepsToNewRule == 0) {
      List? changedDirections;
      setState(() { changedDirections = _directionHandler.changeDirections(); });

      showDialog(context: context, barrierDismissible: false, builder: (context) {
        //Future.delayed(const Duration(seconds: 3), () => Navigator.of(context).pop(true));
        return RuleDialog(direction1: changedDirections![0], direction2: changedDirections![1]);
      }).
      then((value) {
        _continuePlaying();
      });

      return;
    }

    _continuePlaying();
  }

  void _continuePlaying() {
    setState(() {
      _backgroundColor = null;
      _currentSensorDirection = Direction.empty;
      _directionHandler.createNewGivenDirection();
      _needsValues = true;
    });
  }

  void _restart() {
    setState(() {
      _currentSensorDirection = Direction.empty;
      _backgroundColor = null;
      _score = 0;
      _directionHandler.reset();
      _needsValues = true;
    });

    _startListenToSensorEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Column(
          children: [
            //Text('eSense Device Status: \t$_deviceStatus'),
            //Text(_event.toString()),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Score(
                      title: 'SCORE',
                      counter: _score,
                    ),
                  ),
                  DirectionDisplay(givenDirection: _directionHandler.givenDirection, sensorDirection: _currentSensorDirection),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showHelp = !_showHelp;
                      });
                    }, 
                    iconSize: 50,
                    icon: Icon(_showHelp ? Icons.visibility_off_outlined : Icons.visibility_outlined)) ,
                  _showHelp ? HelperCompass(directionHandler: _directionHandler) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}