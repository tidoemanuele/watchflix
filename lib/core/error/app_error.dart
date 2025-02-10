abstract class AppError implements Exception {

  const AppError(this.message, [this.stackTrace]);
  final String message;
  final StackTrace? stackTrace;
}

class NetworkError extends AppError {
  const NetworkError(super.message, [super.stackTrace]);
}

class ApiError extends AppError {
  
  const ApiError(String message, {
    this.statusCode,
    StackTrace? stackTrace,
  }) : super(message, stackTrace);
  final int? statusCode;
}
