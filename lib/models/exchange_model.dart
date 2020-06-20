import 'package:equatable/equatable.dart';

class Excahnge extends Equatable {
  const Excahnge(
    this.base,
    this.date,
    this.rates,
  );

  factory Excahnge.fromJson(Map<String, dynamic> json) {
    return Excahnge(
        json['base'] as String,
        DateTime.parse(json['date'] as String),
        json['rates'] as Map<String, double>);
  }

  final String base;
  final DateTime date;
  final Map<String, double> rates;

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
