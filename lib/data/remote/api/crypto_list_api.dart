import 'package:dio/dio.dart';

abstract class CryptoListApi {
  Future<Response> getCoinsList();
}
