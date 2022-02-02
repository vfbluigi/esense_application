import 'dart:async';

import 'package:esense_application/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class RuleDialog extends StatefulWidget {
  const RuleDialog({ Key? key, required this.direction1, required this.direction2 }) : super(key: key);

  final DirectionObject direction1;
  final DirectionObject direction2;

  @override
  State<RuleDialog> createState() => _RuleDialogState();
}

class _RuleDialogState extends State<RuleDialog> {

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  int _countdown = 3;
  late Timer _timer;

  void _startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 1) {
          setState(() {
            timer.cancel();
          });
          Navigator.pop(context);
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  @override
    void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text(
          'RULE',
          style: TextStyle(
            fontSize: 50,
            color: Colors.orange,
            fontStyle: FontStyle.italic,
          )
        )),
      content: SizedBox(
        height: 170,
        child: Column(
          children: [
            Text(
              '${widget.direction1} and ${widget.direction2} \nare switched',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
            Text(
              '$_countdown',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 70,
              ),
            ),

          ],
        ),
      ),
    );
  }
}