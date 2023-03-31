import 'package:crypto_exchange_app/pages/market_page/market_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../model/coin_model.dart';
import '../../../provider/data_provider.dart';
import '../../../utils/constants.dart';
import 'transactions_screen.dart';
import 'portfolio_coin.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({
    Key? key,
  }) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  late TextEditingController _amountController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _amountController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CoinModel> userCoins = context.watch<DataProvider>().userCoins;
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'My Portfolio',
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Expanded(
            child: userCoins.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: userCoins.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: PortfolioCoin(coin: userCoins[index]),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TransactionsScreen(coinModel: userCoins[index]),
                              ),
                            );
                          });
                    })
                : const CustomError(error: 'No coins added yet.'),
          ),
        ],
      ),
    );
  }
}
