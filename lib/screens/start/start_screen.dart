import 'package:esense_application/screens/esense/esense_chart.dart';
import 'package:esense_application/screens/ingame/screens/esense_screen.dart';
import 'package:esense_application/screens/start/widgets/esense_button.dart';
import 'package:esense_application/screens/start/widgets/start_button.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEAD APP'),
      ),
      body : Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
            ),
            Row(
              children: [
                Expanded(child: StartButton()),
              ],
            ),
            Row(
              children: [
                Expanded(child: ESenseButton(title: 'ESenseChart', nextRoute: ESenseChart(title: 'ESenseChart',),)),
              ],
            ),
            Row(children: [
              Expanded(child: ESenseButton(title: 'ESenseTest', nextRoute: ESenseScreen(),)),
            ],)
          ],
        ),
      ),
    );
  }
}