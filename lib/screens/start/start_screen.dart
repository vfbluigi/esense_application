import 'package:esense_application/screens/esense/esense_chart.dart';
import 'package:esense_application/screens/ingame/screens/connection_screen.dart';
import 'package:esense_application/screens/ingame/screens/esense_screen.dart';
import 'package:esense_application/screens/start/widgets/esense_button.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
              'assets/images/headache.png',
              scale: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 60),
            child: Row(
              children: const [
                Expanded(child: ESenseButton(title: 'Start', nextRoute: '/streambuilder',)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 60),
            child: Row(
              children: const [
                Expanded(child: ESenseButton(title: 'Work in Progress', nextRoute: '/connected',)),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}