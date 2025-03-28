import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/Provider/Bloc/state_bloc.dart';
import 'count_bloc.dart';
import 'event_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>(); // Đọc bloc từ context

    return Scaffold(
      appBar: AppBar(title: Text('Counter BLoC Example')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            int value = 0;
            if (state is CounterValue) value = state.value;
            return Text('Count: $value', style: TextStyle(fontSize: 40));
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () => counterBloc.add(IncrementEvent()), // Hàm tăng
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () => counterBloc.add(DecrementEvent()), // Hàm giảm
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
