part of 'currency_bloc.dart';

class CurrencyState extends Equatable {
  const CurrencyState({int index, List<String> bases})
      : bases = bases ?? const <String>['USD', 'EUR', 'GBP'],
        index = index ?? 0;

  final List<String> bases;
  final int index;

  @override
  List<Object> get props => <dynamic>[index, bases];

  @override
  bool get stringify => true;

  String get currenBase => bases[index];

  CurrencyState copyWith({
    List<String> bases,
    int index,
  }) {
    return CurrencyState(
      bases: bases ?? this.bases,
      index: index ?? this.index,
    );
  }
}
