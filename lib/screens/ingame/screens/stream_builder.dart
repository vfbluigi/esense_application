
import 'package:esense_application/screens/ingame/screens/esense_screen.dart';
import 'package:flutter/material.dart';

import 'package:esense_flutter/esense.dart';
import 'dart:async';

class StreamBuilderScreen extends StatefulWidget {
  const StreamBuilderScreen({ Key? key }) : super(key: key);

  @override
  State<StreamBuilderScreen> createState() => _StreamBuilderScreenState();
}

class _StreamBuilderScreenState extends State<StreamBuilderScreen> {

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
              return ESenseScreen(connection: snapshot.data!.type);
            case ConnectionType.unknown:
              _connectToESense();
              return const LoadingScreen();
            case ConnectionType.disconnected:
              _connectToESense();
              return const LoadingScreen();
            case ConnectionType.device_found:
              return const LoadingScreen();
            case ConnectionType.device_not_found:
              _connectToESense();
              return const LoadingScreen();
          }
        } else {
          return const Center(child: Text("Waiting for Connection Data..."));
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Connecting to eSense...",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}