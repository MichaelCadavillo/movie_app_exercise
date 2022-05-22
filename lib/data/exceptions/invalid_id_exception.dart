class InvalidIdException implements Exception {
  final String? displayMessage;

  InvalidIdException({this.displayMessage});

  @override
  String toString() {
    return "InvalidIdException: $displayMessage";
  }
}
