part of 'exchange_bloc.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();
}

class GetExchange extends ExchangeEvent {
  @override
  List<Object> get props => <dynamic>[];
}

class GetDetailedExchange extends ExchangeEvent {
  const GetDetailedExchange(this.base);

  final String base;

  @override
  List<Object> get props => <dynamic>[base];
}
