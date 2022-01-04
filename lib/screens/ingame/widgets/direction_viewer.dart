import 'package:esense_application/screens/ingame/models/direction.dart';
import 'package:flutter/material.dart';

class DirectionViewer extends StatelessWidget {
  const DirectionViewer({ Key? key, required this.directionHandler }) : super(key: key);

  final DirectionHandler directionHandler;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0,
            child: _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.up))
          ),
          Positioned(
            left: 1,
            top: 50,
            child: _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.left))
          ),
          Positioned(
            right: 1,
            top: 50,
            child: _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.right))
          ),
          Positioned(
            bottom: 0,
            child: _DirectionText(direction: directionHandler.getAssociatedDirection(Direction.down))
          )
        ],
        
      ),
    );
  }
}


class _DirectionText extends StatelessWidget {
  const _DirectionText({ Key? key, required this.direction }) : super(key: key);

  final DirectionObject direction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Text(
        direction.actualDirection.toShortString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 40.0,
        ),
      ),
    );
  }
}