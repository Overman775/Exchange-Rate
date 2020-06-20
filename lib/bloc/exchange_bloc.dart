import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:exchange_rate/data/exchange_exeptions.dart';
import 'package:exchange_rate/data/exchange_repository.dart';
import 'package:exchange_rate/models/exchange_model.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc(this.repository);

  final ExchangeRepository repository;

  @override
  ExchangeState get initialState => ExchangeInitial();

  @override
  Stream<ExchangeState> mapEventToState(
    ExchangeEvent event,
  ) async* {
    yield ExchangeLoading();

    if (event is GetExchange) {
      try {
        final Excahnge exhange = await repository.fetchExchange(null);
        yield ExchangeLoaded(exhange);
      } on ExchangeRepositoryException {
        yield const ExchangeError("Couldn't fetch Exchange. "
            'Is the device online?');
      }
    } else if (event is GetDetailedExchange) {
      try {
        final Excahnge exhange = await repository.fetchExchange(null);
        yield ExchangeLoaded(exhange);
      } on ExchangeRepositoryException {
        yield const ExchangeError("Couldn't fetch Exchange. "
            'Is the device online?');
      }
    }
  }
}
