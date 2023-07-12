import 'package:crypto_list/domain/data_result/data_result.dart';

abstract class CryptoCoinRepository {
  Future<DataResult<List<dynamic>>> getCoinsList();
}
