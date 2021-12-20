enum Direction {
  left,
  right,
  up,
  down,
  empty
}

extension ParseToString on Direction {
  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

class DirectionObject {

  Direction direction;
  late String directionString;

  DirectionObject(this.direction) {
    directionString = direction.toShortString();
  }
}