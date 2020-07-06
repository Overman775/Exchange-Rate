import 'package:equatable/equatable.dart';

class ExcahngeRate extends Equatable {
  const ExcahngeRate({
    this.base,
    this.currency,
    this.date,
  });

  factory ExcahngeRate.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExcahngeRate(
      base: map['base'] as String,
      currency: map['currency'] as double,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
    );
  }

  final String base;
  final double currency;
  final DateTime date;

  @override
  List<Object> get props => <dynamic>[base, currency, date];

  ExcahngeRate copyWith({
    String base,
    double currency,
    DateTime date,
  }) {
    return ExcahngeRate(
      base: base ?? this.base,
      currency: currency ?? this.currency,
      date: date ?? this.date,
    );
  }

  @override
  bool get stringify => true;
}
