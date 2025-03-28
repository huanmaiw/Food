
abstract class CounterState {}

class CounterInitial extends CounterState {}                   // Trạng thái ban đầu
class CounterValue extends CounterState {                      // Trạng thái giá trị
  final int value;
  CounterValue(this.value);
}
