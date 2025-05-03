class StateNotifier<T> {
  final List<void Function(T)> _listeners = [];

  void addListener(void Function(T) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }

  void notifyListeners(T value) {
    for (final listener in List.from(_listeners)) {
      listener(value);
    }
  }

  void dispose() {
    _listeners.clear();
  }
}