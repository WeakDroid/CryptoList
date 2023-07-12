import 'package:crypto_list/data/repositories/crypto_coin/crypto_coin_repository.dart';
import 'package:crypto_list/domain/data_result/data_result.dart';

import 'get_crypto_coins_use_case.dart';

class GetCryptoCoinUseCaseImpl implements GetCryptoCoinUseCase {
  final CryptoCoinRepository coinRepository;

  GetCryptoCoinUseCaseImpl({
    required this.coinRepository,
  });

  @override
  Future<DataResult<List<dynamic>>> getCoinsList() async {
    return coinRepository.getCoinsList();
  }
}
