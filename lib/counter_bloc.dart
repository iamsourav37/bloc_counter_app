import 'dart:async';
import 'dart:developer';

enum CounterAction { increment, decrement }

class CounterBloc {
  int _counter;
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _stateEventController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _stateEventController.sink;
  Stream<CounterAction> get eventStream => _stateEventController.stream;

  CounterBloc() {
    log("counter bloc constructor invoked");
    _counter = 0;
    eventStream.listen((event) {
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

      counterSink.add(_counter);
    });
  }
}
