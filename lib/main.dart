import 'package:esense_application/screens/ingame/screens/connection_screen.dart';
import 'package:esense_application/screens/ingame/screens/gameover_screen.dart';
import 'package:esense_application/screens/ingame/screens/stream_builder.dart';
import 'package:esense_application/screens/start/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESenseApp',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/connection': (context) => const ConnectionScreen(),
        '/streambuilder': (context) => const StreamBuilderScreen(),
      }
    );
  }
}