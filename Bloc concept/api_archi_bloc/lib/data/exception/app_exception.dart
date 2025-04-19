class AppException implements Exception {
  final _message; // Message associated with the exception
  final _prefix; // Prefix for the exception

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_prefix'; // Returns the formatted error message
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication');
}


class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

/// Exception class representing an unauthorized request error.
class UnauthorisedException extends AppException {
  /// Constructor for creating an [UnauthorisedException] instance.
  ///
  /// The [message] parameter represents the error message.
  UnauthorisedException([String? message]) : super(message, 'Unauthorised request');
}

/// Exception class representing an invalid input error.
class InvalidInputException extends AppException {
  /// Constructor for creating an [InvalidInputException] instance.
  ///
  /// The [message] parameter represents the error message.
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

/// Exception class representing a no internet connection error.
class NoInternetException extends AppException {
  /// Constructor for creating a [NoInternetException] instance.
  ///
  /// The [message] parameter represents the error message.
  NoInternetException([String? message]) : super(message, 'No Internet Connection');
}
