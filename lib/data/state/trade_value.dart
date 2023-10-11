import 'package:flutter/cupertino.dart';
import '../models/trade_value.dart';

class TradeValueState extends ChangeNotifier {
  TradeValue? bitcoin, ethereum, tether;

  void updateBitcoinData(List<dynamic>? cryptoData) {
    bitcoin = TradeValue(data: cryptoData!);
    notifyListeners();
  }

  void updateEthereumData(List<dynamic>? cryptoData) {
    ethereum = TradeValue(data: cryptoData!);
    notifyListeners();
  }

  void updateTetherData(List<dynamic>? cryptoData) {
    tether = TradeValue(data: cryptoData!);
    notifyListeners();
  }
}
