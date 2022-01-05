import 'package:esense_application/ingame/models/direction.dart';
import 'package:esense_application/ingame/models/direction_handler.dart';
import 'package:flutter/material.dart';

class HelperCompass extends StatelessWidget {
  const HelperCompass({ Key? key, required this.directionHandler }) : super(key: key);

  final DirectionHandler directionHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.up)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.left)),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/images/compass.png',
                scale: 7,
              ),
            ),
            _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.right)),
          ],
        ),
        _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.down)),
      ],
    );
  }
}


class _DirectionText extends StatelessWidget {
  const _DirectionText({ Key? key, required this.direction }) : super(key: key);

  final DirectionObject direction;

  @override
  Widget build(BuildContext context) {
    return Text(
      direction.actualDirection.toShortString().substring(0,1),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 40.0,
      ),
    );
  }
}