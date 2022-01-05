import 'dart:math';

import 'package:esense_application/ingame/models/direction.dart';

class DirectionHandler {
  
  final Random random = Random();
  static const int _threshold = 5000;

  late List<DirectionObject> directions = [
    DirectionObject(Direction.down),
    DirectionObject(Direction.up),
    DirectionObject(Direction.right),
    DirectionObject(Direction.left)
  ];
  late DirectionObject givenDirection;

  DirectionHandler() {
    createNewGivenDirection();
  }

  void createNewGivenDirection() {
    int index = random.nextInt(directions.length);
    givenDirection = directions[index];
  }

  void reset() {
    directions = [
      DirectionObject(Direction.down),
      DirectionObject(Direction.up),
      DirectionObject(Direction.right),
      DirectionObject(Direction.left)
    ];
    createNewGivenDirection();
  }

  List changeDirections() {
    var n1 = random.nextInt(directions.length);
    var n2 = random.nextInt(directions.length-1);
    if (n2 >= n1) n2 += 1;

    var tempDir = directions[n1].actualDirection;
    directions[n1].actualDirection = directions[n2].actualDirection;
    directions[n2].actualDirection = tempDir;

    return [directions[n1], directions[n2]];
  }

  DirectionObject getAssociatedDirection(Direction dir) {
    return directions.firstWhere((element) => (element.representativeDirection == dir));
  }

  static Direction evaluateDirection(double x, double z) {
    Direction newDirection;
    if (x > _threshold) {
      newDirection = Direction.right;
    } else if (x < -_threshold) {
      newDirection = Direction.left;
    } else if (z > _threshold) {
      newDirection = Direction.down;
    } else if (z < -_threshold) {
      newDirection = Direction.up;
    } else {
      newDirection = Direction.empty;
    }

    return newDirection;
  }
}