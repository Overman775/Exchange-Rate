import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_rate/data/exchange_exeptions.dart';
import 'package:exchange_rate/data/exchange_repository.dart';
import 'package:exchange_rate/models/exchange_model.dart';
import 'package:exchange_rate/models/exhange_detailed_model.dart';
import 'package:flutter/cupertino.dart';

part 'exchange_detail_event.dart';
part 'exchange_detail_state.dart';

class ExchangeDetailBloc
    extends Bloc<ExchangeDetailEvent, ExchangeDetailState> {
  ExchangeDetailBloc(this.repository) : super(ExchangeDetailInitial());

  final ExchangeRepository repository;

  @override
  Stream<ExchangeDetailState> mapEventToState(
    ExchangeDetailEvent event,
  ) async* {
    yield ExchangeDetailLoading();

    if (event is GetExchangeDetail) {
      try {
        final ExcahngeDetailed exhange = await repository.fetchDetailedExchange(
            base: event.base,
            currency: event.currency,
            start:
                event.start ?? DateTime.now().subtract(const Duration(days: 1)),
            end: event.end ?? DateTime.now());
        yield ExchangeDetailLoaded(exhange);
      } on ExchangeRepositoryException catch (error) {
        yield ExchangeDetailError(error.errorString);
      }
    }
  }
}
