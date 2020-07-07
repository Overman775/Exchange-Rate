import 'package:equatable/equatable.dart';

import 'excahnge_rate_model.dart';

class ExcahngeDetailed extends Equatable {
  const ExcahngeDetailed({
    this.rates,
  });

  factory ExcahngeDetailed.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> _ratesObj =
        json['rates'] as Map<String, dynamic>;

    final List<ExcahngeRate> _rates =
        _ratesObj.entries.map((MapEntry<String, dynamic> e) {
      final DateTime _date = DateTime.parse(e.key);
      final Map<String, double> _rate = e.value as Map<String, double>;
      return ExcahngeRate(
          date: _date, base: _rate.keys.first, currency: _rate.values.first);
    }).toList();
    return ExcahngeDetailed(rates: _rates);
  }

  final List<ExcahngeRate> rates;

  @override
  List<Object> get props => <dynamic>[rates];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'rates': rates?.map((ExcahngeRate x) => x?.toMap())?.toList(),
    };
  }
}

/*
{
   "rates":{
      "2018-08-27":{
         "JPY":111.0289693114
      },
      "2018-08-22":{
         "JPY":110.261707989
      },
      "2018-08-01":{
         "JPY":111.8416552668
      },
      "2018-08-28":{
         "JPY":111.0418445773
      },
*/
