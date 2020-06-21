import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/exchange_exeptions.dart';
import '../data/exchange_repository.dart';
import '../models/exchange_model.dart';

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
        final Excahnge exhange =
            await repository.fetchExchange(base: event.base);
        yield ExchangeLoaded(exhange);
      } on ExchangeRepositoryException catch (error) {
        yield ExchangeError(error.errorString);
      }
    }
  }
}
