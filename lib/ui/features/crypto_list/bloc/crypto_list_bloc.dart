import 'dart:async';

import 'package:crypto_list/core/data_result_processor.dart';
import 'package:crypto_list/domain/use_cases/get_crypto_coins_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/crypto_coin.dart';

part 'crypto_list_event.dart';

part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final GetCryptoCoinUseCase cryptoCoinUseCase;

  CryptoListBloc(this.cryptoCoinUseCase) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      if (state is! CryptoListLoaded) {
        emit(CryptoListLoading());
      }

      final listResult = await cryptoCoinUseCase.getCoinsList();

      DataResultProcessor<List<CryptoCoin>>.processResult(
        dataResult: listResult,
        onSuccess: (data) => emit(CryptoListLoaded(coinsList: data)),
        onFailure: (_) => emit(CryptoListLoadingFailure()),
        onError: (_) => emit(CryptoListLoadingFailure()),
      );

      event.completer?.complete();
    });
  }
}
