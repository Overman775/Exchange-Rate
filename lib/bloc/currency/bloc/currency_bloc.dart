import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  @override
  CurrencyState get initialState => const CurrencyState();

  @override
  Stream<CurrencyState> mapEventToState(
    CurrencyEvent event,
  ) async* {
    if (event is CurrencySetIndexEvent) {
      yield initialState.copyWith(index: event.index);
    } else if (event is CurrencySetBaseEvent) {
      yield initialState.copyWith(bases: event.bases);
    }
  }
}
