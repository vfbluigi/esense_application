import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({ Key? key, required this.title, required this.counter, this.color}) : super(key: key);

  final String title;
  final int counter;
  final MaterialColor? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40.0,
              color: color,
            )
          ),
          Text(
            '$counter',
            style: TextStyle(
              fontSize: 80.0,
              color: color,
            )
          ),
      ],
    );
  }
}