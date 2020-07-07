part of 'exchange_detail_bloc.dart';

abstract class ExchangeDetailState extends Equatable {
  const ExchangeDetailState();
}

class ExchangeDetailInitial extends ExchangeDetailState {
  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeDetailLoading extends ExchangeDetailState {
  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeDetailLoaded extends ExchangeDetailState {
  const ExchangeDetailLoaded(this.exchange);

  final ExcahngeDetailed exchange;

  @override
  List<Object> get props => <dynamic>[];
}

class ExchangeDetailError extends ExchangeDetailState {
  const ExchangeDetailError(this.message);

  final String message;

  @override
  List<Object> get props => <dynamic>[message];
}
