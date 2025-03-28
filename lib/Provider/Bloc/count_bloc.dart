

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Provider/Bloc/state_bloc.dart';

import 'event_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _counter = 0;

  CounterBloc() : super(CounterInitial()) {
    // Lắng nghe các sự kiện
    on<IncrementEvent>((event, emit) => _increment(emit));
    on<DecrementEvent>((event, emit) => _decrement(emit));
  }

  // Hàm tăng giá trị
  void _increment(Emitter<CounterState> emit) {
    _counter++; // Tăng giá trị
    emit(CounterValue(_counter)); // Phát ra trạng thái mới
  }

  // Hàm giảm giá trị
  void _decrement(Emitter<CounterState> emit) {
    _counter--; // Giảm giá trị
    emit(CounterValue(_counter)); // Phát ra trạng thái mới
  }
}
