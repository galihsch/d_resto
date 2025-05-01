sealed class ApiState<T> {
  const ApiState();
}

final class ApiLoadingState<T> extends ApiState<T> {
  const ApiLoadingState();
}

final class ApiLoadedState<T> extends ApiState<T> {
  final T data;
  const ApiLoadedState(this.data);
}

final class ApiErrorState<T> extends ApiState<T> {
  final String message;
  const ApiErrorState(this.message);
}
