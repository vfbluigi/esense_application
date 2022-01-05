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