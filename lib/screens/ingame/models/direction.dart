import 'dart:math';

enum Direction {
  left,
  right,
  up,
  down,
  empty
}

extension ParseToString on Direction {
  String toShortString() {
    if (this == Direction.empty) {
      return "___";
    }

    return toString().split('.').last.toUpperCase();
  }
}

class DirectionObject {

  Direction actualDirection;
  late Direction representativeDirection;

  DirectionObject(this.actualDirection) {
    representativeDirection = actualDirection;
  }

  @override
  String toString() {
    return representativeDirection.toShortString();
  }
}


class DirectionHandler {
  
  final Random random = Random();


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



}