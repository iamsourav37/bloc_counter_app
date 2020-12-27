import 'dart:async';
import 'dart:developer';

enum CounterAction { increment, decrement }

abstract class Dispose {
  void dispose();
}

class CounterBloc implements Dispose {
  int _counter;
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _stateEventController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _stateEventController.sink;
  Stream<CounterAction> get _eventStream => _stateEventController.stream;

  CounterBloc() {
    log("counter bloc constructor invoked");
    _counter = 0;
    _eventStream.listen((event) {
      log("eventStream.listen() method invoked");
      switch (event) {
        case CounterAction.increment:
          _counter++;
          // busines logic
          break;
        case CounterAction.decrement:
          if (!(_counter <= -1)) _counter--;
          // busines logic
          break;
      }
      _counterSink.add(_counter);
    });
  }

  @override
  void dispose() {
    _stateStreamController.close();
    _stateEventController.close();
  }
}
