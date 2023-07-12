import 'dart:async';

import 'package:crypto_list/domain/use_cases/get_crypto_coins_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/crypto_list_bloc.dart';
import '../widgets/crypto_coin_tile.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({
    super.key,
  });

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<GetCryptoCoinUseCase>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoCurrenciesList'),
      ),
      body: _buildScreen(theme),
    );
  }

  RefreshIndicator _buildScreen(ThemeData theme) {
    return RefreshIndicator(
      onRefresh: () async {
        final completer = Completer();
        _cryptoListBloc.add(LoadCryptoList(completer: completer));
        return completer.future;
      },
      child: BlocBuilder<CryptoListBloc, CryptoListState>(
        bloc: _cryptoListBloc,
        builder: (context, state) {
          if (state is CryptoListLoaded) {
            return _buildCryptoList(state);
          }
          if (state is CryptoListLoadingFailure) {
            return _buildLoadedErrorState(theme, state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildCryptoList(CryptoListLoaded state) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: state.coinsList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, i) {
        final coin = state.coinsList[i];
        return CryptoCoinTile(coin: coin);
      },
    );
  }

  Center _buildLoadedErrorState(ThemeData theme, String? errorText) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errorText ?? "Something went wrong. Please try again later",
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {
              _cryptoListBloc.add(LoadCryptoList());
            },
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
