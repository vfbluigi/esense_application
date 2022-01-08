import 'package:esense_application/about/about_screen.dart';
import 'package:esense_application/settings/settings_screen.dart';
import 'package:esense_application/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'ingame/screens/esense_connection_screen.dart';

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
        '/streambuilder': (context) => const ESenseConnectionScreen(),
        '/about': (context) => const AboutScreen(),
        '/settings': (context) => const SettingsScreen(),
      }
    );
  }
}