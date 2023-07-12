import 'package:crypto_list/data/remote/api/api_constants.dart';

class CryptoCoinRemote {
  String? name;
  double? priceInUSD;
  String? imageUrl;

  CryptoCoinRemote(this.name,
      this.priceInUSD,
      this.imageUrl,);

  CryptoCoinRemote.fromJson(MapEntry e) {
    final usdData =
    (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
    name = e.key;
    priceInUSD = usdData['PRICE'];
    imageUrl = '${ApiConstants.pictureBaseUrl}${usdData['IMAGEURL']}';
  }
}
