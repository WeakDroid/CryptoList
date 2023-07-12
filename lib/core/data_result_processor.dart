import '../domain/data_result/data_result.dart';

class DataResultProcessor<T> {
  DataResultProcessor.processResult({
    required DataResult dataResult,
    required Function(T) onSuccess,
    required Function(Failure) onFailure,
    required Function(Error) onError,
  }) {
    if (dataResult.success != null) {
      onSuccess((dataResult.success!.data));
    } else {
      if (dataResult.error != null) {
        onError((dataResult.error!));
      } else {
        if (dataResult.failure != null) {
          onFailure(Failure(exception: dataResult.failure!.exception));
        }
      }
    }
  }
}
