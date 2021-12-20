import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({ Key? key, required this.counter}) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          const Text(
            'SCORE',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40.0,
            )
          ),
          Text(
            '$counter',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 80.0,
            )
          ),
      ],
    );
  }
}