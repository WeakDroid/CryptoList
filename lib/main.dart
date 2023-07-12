import 'package:flutter/material.dart';

import 'crypto_coins_list_app.dart';
import 'di/locator.dart';

void main() async {
  await init();

  runApp(const CryptoCurrenciesListApp());
}

Future init() async {
  setupLocator();
}
