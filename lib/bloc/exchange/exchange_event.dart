part of 'exchange_bloc.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();
}

class GetExchange extends ExchangeEvent {
  const GetExchange(this.base);

  final String base;

  @override
  List<Object> get props => <dynamic>[base];
}
