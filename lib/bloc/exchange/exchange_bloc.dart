import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_rate/data/exchange_exeptions.dart';
import 'package:exchange_rate/data/exchange_repository.dart';
import 'package:exchange_rate/models/exchange_model.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc(this.repository) : super(ExchangeInitial());

  final ExchangeRepository repository;

  @override
  Stream<ExchangeState> mapEventToState(
    ExchangeEvent event,
  ) async* {
    yield ExchangeLoading();

    if (event is GetExchange) {
      try {
        final Excahnge exhange =
            await repository.fetchExchange(base: event.base);
        yield ExchangeLoaded(exhange);
      } on ExchangeRepositoryException catch (error) {
        yield ExchangeError(error.errorString);
      }
    }
  }
}
