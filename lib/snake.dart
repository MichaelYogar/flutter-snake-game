class Snake {
  Snake({required this.positions});

  void addTo(int value) {
    positions.add(value);
  }

  List<int> positions;
}
