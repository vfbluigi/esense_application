import 'package:flutter/material.dart';

class CurrentDirection extends StatelessWidget {
  const CurrentDirection ({ Key? key , required this.title, required this.x, required this.y, required this.z}) : super(key: key);

  final String title;
  final double x;
  final double y;
  final double z;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 40.0,
          ),
        ),
        Text('x = $x \n y = $y \n z = $z'),
      ],
    );
  }
}