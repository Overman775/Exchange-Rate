import 'package:equatable/equatable.dart';

abstract class ExchangeRepositoryException extends Equatable
    implements Exception {
  const ExchangeRepositoryException([this._message, this._prefix]);
  final String _message;
  final String _prefix;

  @override
  List<Object> get props => <String>[_message, _prefix];

  @override
  bool get stringify => true;

  String get errorString => '$_prefix $_message';
}

class FetchDataException extends ExchangeRepositoryException {
  const FetchDataException([String message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends ExchangeRepositoryException {
  const BadRequestException([String message])
      : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ExchangeRepositoryException {
  const UnauthorisedException([String message])
      : super(message, 'Unauthorised: ');
}

class InvalidInputException extends ExchangeRepositoryException {
  const InvalidInputException([String message])
      : super(message, 'Invalid Input: ');
}
