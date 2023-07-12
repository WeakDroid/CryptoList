import 'package:crypto_list/data/remote/models/crypto_coin_remote.dart';
import 'package:crypto_list/domain/models/crypto_coin.dart';

class CryptoCoinRemoteToCryptoCoinMapper {
  static CryptoCoin fromApi(CryptoCoinRemote remote) {
    return CryptoCoin(
        name: remote.name ?? "",
        priceInUSD: remote.priceInUSD ?? 0,
        imageUrl: remote.imageUrl ?? "");
  }
}
