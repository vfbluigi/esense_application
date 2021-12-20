import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/screens/ingame/screens/play_screen2.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class ESenseScreen extends StatefulWidget {
  const ESenseScreen({Key? key}) : super(key: key);

  @override
  _ESenseScreenState createState() => _ESenseScreenState();
}

class _ESenseScreenState extends State<ESenseScreen> {
  String _deviceStatus = '';
  bool sampling = false;
  SensorEvent? _event;
  bool connected = false;

  // the name of the eSense device to connect to -- change this to your own device.
  final String eSenseName = 'eSense-0864';

  @override
  void initState() {
    super.initState();
    _connectToESense();
    _listenToESense();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  Future _listenToESense() async {
    // if you want to get the connection events when connecting,
    // set up the listener BEFORE connecting...
    ESenseManager().connectionEvents.listen((event) {
      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected) {

        _startListenToSensorEvents();

        setState(() {
          _counter++;
        });
      }  

      setState(() {
        connected = false;
        switch (event.type) {
          case ConnectionType.connected:
            _deviceStatus = 'connected';
            connected = true;
            break;
          case ConnectionType.unknown:
            _deviceStatus = 'unknown';
            _connectToESense();
            break;
          case ConnectionType.disconnected:
            _deviceStatus = 'disconnected';
            _connectToESense();
            break;
          case ConnectionType.device_found:
            _deviceStatus = 'device_found';
            break;
          case ConnectionType.device_not_found:
            _deviceStatus = 'device_not_found';
            _connectToESense();
            break;
        }
      });
    });
  }

  Future<void> _connectToESense() async {
    await ESenseManager().disconnect();
    bool hasSuccessfulConneted = await ESenseManager().connect(eSenseName);
    print("hasSuccessfulConneted: $hasSuccessfulConneted");
  }

  StreamSubscription? subscription;
  void _startListenToSensorEvents() async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) {
      sleep(const Duration(milliseconds: 5));

      setState(() {
        _event = event;
      });
      _evaluateSensorDirection();
    });

    setState(() {
      sampling = true;
    });
  }

  void _pauseListenToSensorEvents() async {
    subscription?.cancel();
    setState(() {
      sampling = false;
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    ESenseManager().disconnect();
    super.dispose();
  }

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
    int randomIndex = random.nextInt(3);
    setState(() {
      currentGivenDirection = directions[randomIndex];
    });
  }

  void _evaluateSensorDirection() {
    double x = 0;
    double z = 0;
    if (_event != null) {
      x = _event!.gyro![0].toDouble();
      z = _event!.gyro![2].toDouble();
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

    setState(() {
      currentSensorDirection = newDirection;
    });
  }

  void _incrementCounter() {
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
        children: [
          Text('eSense Device Status: \t$_deviceStatus'),
          Text(_event.toString()),
          ElevatedButton(
              onPressed: () => _connectToESense(), child: Text('Connect')),
          Center(
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
                ElevatedButton(
                    onPressed: () {
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
          ),
        ],
      ),
    );
  }
}
