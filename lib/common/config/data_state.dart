abstract class DataState<T> {
  final String? error;
  final T? body;
  const DataState({
    this.error,
    this.body,
  });
}

class DataSuccess<T> extends DataState {
  const DataSuccess(T body) : super(body: body);
}

class DataFailed extends DataState {
  const DataFailed(String error) : super(error: error);
}
