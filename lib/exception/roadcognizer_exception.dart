class RoadcognizerException implements Exception {
  final String message;

  RoadcognizerException(this.message);

  @override
  String toString() {
    return message;
  }
}
