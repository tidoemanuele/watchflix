abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Error<T> extends Result<T> {
  const Error(this.message);
  final String message;
}

class Loading<T> extends Result<T> {
  const Loading();
}
