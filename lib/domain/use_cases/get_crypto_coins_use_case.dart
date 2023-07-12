import '../data_result/data_result.dart';

abstract class GetCryptoCoinUseCase {
  Future<DataResult<List<dynamic>>> getCoinsList();
}