class Snake {
  Snake({
    required this.positions,
  });

  List<int> get currentPositions {
    return positions;
  }

  final List<int> positions;
}
