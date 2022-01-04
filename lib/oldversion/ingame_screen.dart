import 'dart:io';
import 'dart:math';

import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:esense_application/oldversion/current_direction.dart';
import 'package:esense_application/screens/ingame/widgets/given_direction.dart';
import 'package:esense_application/screens/ingame/widgets/score.dart';
import 'package:flutter/material.dart';

import 'package:esense_flutter/esense.dart';
import 'dart:async';

class InGameScreen extends StatefulWidget {
  const InGameScreen({ Key? key }) : super(key: key);

  @override
  State<InGameScreen> createState() => _InGameScreenState();
}

class _InGameScreenState extends State<InGameScreen> {

  final String _eSenseName = "eSense-0864";

  @override
  void initState() {
    super.initState();
    _connectToESense();
  }

  Future<void> _connectToESense() async {
    await ESenseManager().disconnect();
    bool hasSuccessfulConneted = await ESenseManager().connect(_eSenseName);
    print("hasSuccessfulConneted: $hasSuccessfulConneted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<ConnectionEvent>(
              stream: ESenseManager().connectionEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.type) {
                    case ConnectionType.connected:
                      return Text('hi');
                    case ConnectionType.unknown:
                      _connectToESense();
                      return const Text("Connection: Unknown");
                    case ConnectionType.disconnected:
                      _connectToESense();
                      return const Text("Connection: Disconnected");
                    case ConnectionType.device_found:
                      return const Center(child: Text("Connection: Device found"));
                    case ConnectionType.device_not_found:
                      _connectToESense();
                      return Text("Connection: Device not found - $_eSenseName");
                  }
                } else {
                  return const Center(child: Text("Waiting for Connection Data..."));
                }
              },
            ),
          ],
        ),
      )
    );
  }
}

class SensorData extends StatelessWidget {
  const SensorData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SensorEvent>(
      stream: ESenseManager().sensorEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          sleep(const Duration(milliseconds: 500));
          double x = snapshot.data!.gyro![0].toDouble();
          double y = snapshot.data!.gyro![1].toDouble();
          double z = snapshot.data!.gyro![2].toDouble();
          if (x > 5000) {
            sleep(const Duration(milliseconds: 1000));
            return CurrentDirection(title: 'RIGHT',x: x,y: y,z: z);
          } else if(x < -5000) {
            sleep(const Duration(milliseconds: 1000));
            return CurrentDirection(title: 'LEFT',x: x,y: y,z: z);
          } else if(z > 5000) {
            sleep(const Duration(milliseconds: 1000));
            return CurrentDirection(title: 'DOWN',x: x,y: y,z: z);
          } else if(z < -5000) {
            sleep(const Duration(milliseconds: 1000));
            return CurrentDirection(title: 'UP',x: x,y: y,z: z);
          } else {
            return CurrentDirection(title: '-',x: x,y: y,z: z); 
          }

        }
        return const Text('no value');
      },
    );
  }
}