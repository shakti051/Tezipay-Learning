// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counterValue;
  const CounterState({required this.counterValue});

  @override
  List<Object> get props => [counterValue];

  CounterState copyWith({int? counterValue}) {
    return CounterState(counterValue: counterValue ?? this.counterValue);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'counterValue': counterValue};
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(counterValue: map['counterValue'] as int);
  }

  @override
  bool get stringify => true;
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(counterValue: 0);
}

class IncrementState extends CounterState {
  const IncrementState(int increasedValue)
    : super(counterValue: increasedValue);
}

class DecrementState extends CounterState {
  const DecrementState(int decreasedValue)
    : super(counterValue: decreasedValue);
}
