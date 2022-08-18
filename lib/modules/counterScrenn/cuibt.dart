import 'package:application/modules/counterScrenn/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCuibt extends Cubit<CounterState> {
  CounterCuibt() : super(CounterInitialState());

  static CounterCuibt get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
  }

  void plass() {
    counter++;
    emit(CounterPlassState(counter));
  }
}
