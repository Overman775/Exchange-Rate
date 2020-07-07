import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;

import '../data/exchange_exeptions.dart';
import '../models/exchange_model.dart';
import '../models/exhange_detailed_model.dart';

abstract class ExchangeRepository {
  Future<Excahnge> fetchExchange({String base});
  Future<ExcahngeDetailed> fetchDetailedExchange(
      {String base, String currency, DateTime start, DateTime end});
}

class ExchangeRepositoryECB implements ExchangeRepository {
  //European Central Bank
  final String _baseUrl = 'https://api.exchangeratesapi.io';
  final DateFormat _dateTimeFomater = DateFormat('yyyy-MM-dd');

  @override
  Future<Excahnge> fetchExchange({String base = 'USD'}) async {
    Map<String, dynamic> responseJson;
    try {
      final http.Response response =
          await http.get('$_baseUrl/latest?base=$base');
      responseJson = _returnResponse(response) as Map<String, dynamic>;
    } on SocketException {
      throw const FetchDataException('No Internet connection');
    }
    return Excahnge.fromJson(responseJson);
  }

  @override
  Future<ExcahngeDetailed> fetchDetailedExchange(
      {String base, String currency, DateTime start, DateTime end}) async {
    Map<String, dynamic> responseJson;
    final String reqwest = '$_baseUrl/history?base=$base&symbols$currency'
        '&start_at=${_dateTimeFomater.format(start)}'
        '&end_at=${_dateTimeFomater.format(end)}';
    try {
      final http.Response response = await http.get(reqwest);
      responseJson = _returnResponse(response) as Map<String, dynamic>;
    } on SocketException {
      throw const FetchDataException('No Internet connection');
    }
    return ExcahngeDetailed.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseJson =
            json.decode(response.body) as Map<String, dynamic>;
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server '
            'with StatusCode : ${response.statusCode}');
    }
  }
}
