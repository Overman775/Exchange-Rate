part of 'exchange_bloc.dart';

abstract class ExchangeState extends Equatable {
  const ExchangeState();
}

class ExchangeInitial extends ExchangeState {
  @override
  List<Object> get props => [];
}
