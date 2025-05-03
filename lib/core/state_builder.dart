import 'package:flutter/widgets.dart';
import 'state_store.dart';

class StateBuilder<T> extends StatefulWidget {
  final StateStore<T> store;
  final Widget Function(BuildContext context, T value) builder;

  const StateBuilder({
    super.key,
    required this.store,
    required this.builder,
  });

  @override
  State<StateBuilder<T>> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.store.value;
    widget.store.listen(_update);
  }

  void _update(T newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });
    }
  }

  @override
  void dispose() {
    widget.store.unlisten(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}
