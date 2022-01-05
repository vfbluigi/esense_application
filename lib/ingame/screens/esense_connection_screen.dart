
import 'package:esense_application/ingame/screens/game_screen.dart';
import 'package:flutter/material.dart';

import 'package:esense_flutter/esense.dart';
import 'dart:async';

class ESenseConnectionScreen extends StatefulWidget {
  const ESenseConnectionScreen({ Key? key }) : super(key: key);

  @override
  State<ESenseConnectionScreen> createState() => _ESenseConnectionScreenState();
}

class _ESenseConnectionScreenState extends State<ESenseConnectionScreen> {

  final String _eSenseName = "eSense-0864";

  ConnectionType connection = ConnectionType.unknown;

  @override
  void initState() {
    super.initState();
    _connectToESense();
  }

  Future<void> _connectToESense() async {
    await ESenseManager().disconnect();
    await ESenseManager().connect(_eSenseName);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionEvent>(
      stream: ESenseManager().connectionEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          switch (snapshot.data!.type) {
            case ConnectionType.connected:
              return GameScreen(connection: snapshot.data!.type);
            case ConnectionType.device_found:
              return const LoadingScreen(message: 'Connection found...');
            default:
              _connectToESense();
              return const LoadingScreen(message: 'Connecting to ESense...');
          }
        } else {
          _connectToESense();
          return const LoadingScreen(message: 'Connecting to ESense...');
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key? key, required this.message }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                ),
              ),
            ),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}