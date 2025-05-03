import 'dart:async';
import 'state_notifier.dart';

class StateStore<T> {
  final T _initialValue;
  T _value;
  final _notifier = StateNotifier<T>();

  StateStore(this._initialValue) : _value = _initialValue;

  T get value => _value;

  void set(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notifier.notifyListeners(_value);
    }
  }

  Future<void> setAsync(Future<T> Function() asyncUpdater) async {
    final newValue = await asyncUpdater();
    set(newValue);
  }

  void reset() {
    set(_initialValue);
  }

  void listen(void Function(T) listener) {
    _notifier.addListener(listener);
  }

  void unlisten(void Function(T) listener) {
    _notifier.removeListener(listener);
  }

  void dispose() {
    _notifier.dispose();
  }
}