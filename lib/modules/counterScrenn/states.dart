import 'package:bloc/bloc.dart';

abstract class CounterState {}

class CounterInitialState extends CounterState {}

class CounterPlassState extends CounterState {
  final int Counter;

  CounterPlassState(this.Counter);
}

class CounterMinusState extends CounterState {
  final int Counter;

  CounterMinusState(this.Counter);
}
