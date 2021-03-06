import 'package:equatable/equatable.dart';

import 'excahnge_rate_model.dart';

class Excahnge extends Equatable {
  const Excahnge(
    this.base,
    this.date,
    this.rates,
  );

  factory Excahnge.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> _ratesObj =
        json['rates'] as Map<String, dynamic>;
    final List<ExcahngeRate> _rates = _ratesObj.entries
        .map((MapEntry<String, dynamic> e) =>
            ExcahngeRate(base: e.key, currency: e.value as double))
        .toList();
    return Excahnge(
        json['base'] as String, DateTime.parse(json['date'] as String), _rates);
  }

  final String base;
  final DateTime date;
  final List<ExcahngeRate> rates;

  @override
  List<Object> get props => <dynamic>[base, date, rates];

  @override
  bool get stringify => true;
}

/*
{
  "base": "EUR",
  "date": "2018-04-08",
  "rates": {
    "CAD": 1.565,
    "CHF": 1.1798,
    "GBP": 0.87295,
    "SEK": 10.2983,
    "EUR": 1.092,
    "USD": 1.2234,
    ...
  }
}
*/
