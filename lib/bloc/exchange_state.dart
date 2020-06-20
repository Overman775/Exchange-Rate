part of 'exchange_bloc.dart';

abstract class ExchangeState extends Equatable {
  const ExchangeState();
}

class ExchangeInitial extends ExchangeState {
  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeLoading extends ExchangeState {
  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeLoaded extends ExchangeState {
  const ExchangeLoaded(this.exchange);

  final Excahnge exchange;

  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeError extends ExchangeState {
  const ExchangeError(this.message);

  final String message;

  @override
  List<Object> get props => <dynamic>[message];
}
