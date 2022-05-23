class ApiCallException implements Exception {
  final String? displayMessage;

  ApiCallException({this.displayMessage});

  @override
  String toString() {
    return "ApiCallException: $displayMessage";
  }
}
