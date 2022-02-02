import 'package:esense_application/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class DirectionDisplay extends StatelessWidget {
  const DirectionDisplay({ Key? key, required this.givenDirection, required this.sensorDirection }) : super(key: key);

  final DirectionObject givenDirection;
  final Direction sensorDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.0,
      height: 150.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 20,
            child: _DirectionText(caption: 'GIVEN', direction: givenDirection)
          ),
          Positioned(
            right: 20,
            child: _DirectionText(caption: 'INPUT', direction: DirectionObject(sensorDirection), color: Colors.blue)
          ),
        ],)
    );
  }
}

class _DirectionText extends StatelessWidget {
  const _DirectionText({ Key? key, this.caption = '', required this.direction, this.color = Colors.blue }) : super(key: key);

  final DirectionObject direction;
  final String caption;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Text(
            caption,
            style: const TextStyle(
              fontSize: 40.0,
              color: Colors.orange,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$direction',
            style: const TextStyle(
                fontSize: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}