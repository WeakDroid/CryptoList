class DataResult<T> {
  final Success? success;
  final Error? error;
  final Failure? failure;
  final Loading? loading;

  DataResult(
      {this.success,
      this.error,
      this.failure,
      this.loading});
}

class Success<T> {
  final T data;

  Success({required this.data});
}

class Error {
  final int? code;
  final String message;

  Error({required this.code, required this.message});
}

class Failure {
  final Exception exception;

  Failure({required this.exception});
}

class Loading {
  final bool isLoading;

  Loading({required this.isLoading});
}
