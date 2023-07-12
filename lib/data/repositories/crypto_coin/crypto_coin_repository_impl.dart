import 'package:crypto_list/data/remote/api/crypto_list_api.dart';
import 'package:crypto_list/data/remote/models/crypto_coin_remote.dart';
import 'package:crypto_list/data/repositories/mappers/mappers.dart';
import 'package:crypto_list/domain/data_result/data_result.dart';

import '../../../domain/models/crypto_coin.dart';
import '../safe_api_call.dart';
import 'crypto_coin_repository.dart';

class CryptoCoinRepositoryImpl implements CryptoCoinRepository {
  final CryptoListApi api;

  CryptoCoinRepositoryImpl({
    required this.api,
  });

  @override
  Future<DataResult<List<CryptoCoin>>> getCoinsList() async {
    return safeApiCall(
      processedData: (dataRemote) => DataResult<List<CryptoCoin>>(
          success: Success<List<CryptoCoin>>(
              data: _processRaw(dataRemote)
                  .map((e) => CryptoCoinRemoteToCryptoCoinMapper.fromApi(e))
                  .toList())),
      apiCall: () => api.getCoinsList(),
    );
  }

  List<CryptoCoinRemote> _processRaw(Map<String, dynamic> data) {
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    List<CryptoCoinRemote> cryptoCoinsRemoteList =
        dataRaw.entries.map((e) => CryptoCoinRemote.fromJson(e)).toList();

    return cryptoCoinsRemoteList;
  }
}
