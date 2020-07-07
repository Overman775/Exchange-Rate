part of 'exchange_detail_bloc.dart';

abstract class ExchangeDetailEvent extends Equatable {
  const ExchangeDetailEvent();
}

class GetExchangeDetail extends ExchangeDetailEvent {
  const GetExchangeDetail(
      {@required this.base, @required this.currency, this.start, this.end});

  final String base;
  final String currency;
  final DateTime start;
  final DateTime end;

  @override
  List<Object> get props => <dynamic>[base, currency, start, end];

  @override
  bool get stringify => true;
}
