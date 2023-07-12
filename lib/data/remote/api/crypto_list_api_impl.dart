import 'package:crypto_list/data/remote/api/api_constants.dart';
import 'package:dio/dio.dart';

import 'crypto_list_api.dart';

class CryptoListApiImpl implements CryptoListApi {
  CryptoListApiImpl({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<Response> getCoinsList() async {
    return await _get(ApiConstants.getCryptoListAddress);
  }

  Future<Response<dynamic>> _get(String address) async {
    return dio.get('${ApiConstants.baseUrl}$address');
  }
}
