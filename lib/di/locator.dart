import 'package:crypto_list/data/remote/api/crypto_list_api.dart';
import 'package:crypto_list/data/remote/api/crypto_list_api_impl.dart';
import 'package:crypto_list/data/repositories/crypto_coin/crypto_coin_repository.dart';
import 'package:crypto_list/domain/use_cases/get_crypto_coins_use_case.dart';
import 'package:crypto_list/domain/use_cases/get_crypto_coins_use_case_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/crypto_coin/crypto_coin_repository_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CryptoListApi>(
      () => CryptoListApiImpl(dio: Dio()));
  locator.registerLazySingleton<CryptoCoinRepository>(
      () => CryptoCoinRepositoryImpl(api: locator<CryptoListApi>()));
  locator.registerLazySingleton<GetCryptoCoinUseCase>(() =>
      GetCryptoCoinUseCaseImpl(
          coinRepository: locator<CryptoCoinRepository>()));
}
