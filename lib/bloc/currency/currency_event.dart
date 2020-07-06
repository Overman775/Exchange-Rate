part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class CurrencySetIndexEvent extends CurrencyEvent {
  const CurrencySetIndexEvent(this.index);

  final int index;
  @override
  List<Object> get props => <dynamic>[index];
}

class CurrencySetBaseEvent extends CurrencyEvent {
  const CurrencySetBaseEvent(this.bases);

  final List<String> bases;

  @override
  List<Object> get props => <dynamic>[bases];
}
