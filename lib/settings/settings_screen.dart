import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static int stepsTillRule = 5;
  static String currentDropDownValue = 'NORMAL';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String dropdownValue = SettingsScreen.currentDropDownValue;

  void _setStepsTillRule() {
    switch(dropdownValue) {
      case 'EASY':
        SettingsScreen.stepsTillRule = 10;
        break;
      case 'NORMAL':
        SettingsScreen.stepsTillRule = 5;
        break;
      case 'HARD':
        SettingsScreen.stepsTillRule = 3;
        break;
      case 'EXTREME':
        SettingsScreen.stepsTillRule = 1;
        break;
    }
  }

  @override
  void dispose() {
    SettingsScreen.currentDropDownValue = dropdownValue;
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SETTINGS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 60,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'GAME MODE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                  )
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.orange),
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  _setStepsTillRule();
                },
                items: <String>['EASY', 'NORMAL', 'HARD', 'EXTREME']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
