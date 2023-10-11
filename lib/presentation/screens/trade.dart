import 'package:flutter/material.dart';
import "../routes.dart";
import "../pages/chart.dart";
import '../../services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:sgpaypoint/data/state/trade_value.dart';
import 'package:sgpaypoint/data/models/trade_value.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  List<dynamic>? btc, ethereum, tether;
  String btcCurrentMarketPrice = "0.0",
      ethCurrentMarketPrice = "0.0",
      tetherCurrentMarketPrice = "0.0";

  // Future<void> fetchCryptoData() async {
  //   List<dynamic> bitcoin_data =
  //       await Services().fetchCryptoPriceData("bitcoin") as List<dynamic>;
  //   // fetchTodayCryptoPrice(bitcoin_data, "bitcoin");

  //   print(bitcoin_data);
  //   print("----------------------------------\n");
  //   print(Provider.of<TradeValueState>(context, listen: false).bitcoin);

  //   List<dynamic> ethereum_data =
  //       await Services().fetchCryptoPriceData("ethereum") as List<dynamic>;
  //   // fetchTodayCryptoPrice(ethereum_data, "ethereum");

  //   List<dynamic> tether_data =
  //       await Services().fetchCryptoPriceData("tether") as List<dynamic>;
  //   // fetchTodayCryptoPrice(tether_data, "tether");

  //   setState(
  //     () {
  //       btc = bitcoin_data;
  //       ethereum = ethereum_data;
  //       tether = tether_data;
  //     },
  //   );
  // }

  Future<void> fetchTodayCryptoPrice(
      TradeValue? currencyValue, String cryptoName) async {
    final today = DateTime.now();
    final lastEntry = currencyValue!.data.last;
    final timestamp =
        DateTime.fromMillisecondsSinceEpoch(lastEntry['time'].toInt() * 1000);

    if (lastEntry != null) {
      final todayPrice = double.parse(lastEntry['priceUsd']).toStringAsFixed(2);

      if (cryptoName == "bitcoin") {
        setState(
          () {
            btcCurrentMarketPrice = todayPrice;
          },
        );
      } else if (cryptoName == "ethereum") {
        setState(
          () {
            ethCurrentMarketPrice = todayPrice;
          },
        );
      } else {
        setState(
          () {
            tetherCurrentMarketPrice = todayPrice;
          },
        );
      }
    } else {
      // Today's data not found in the history
      setState(() {
        if (cryptoName == "bitcoin") {
          setState(
            () {
              btcCurrentMarketPrice = "0.0";
            },
          );
        } else if (cryptoName == "ethereum") {
          setState(
            () {
              ethCurrentMarketPrice = "0.0";
            },
          );
        } else {
          setState(
            () {
              tetherCurrentMarketPrice = "0.0";
            },
          );
        }
      });
    }
  }

  void initState() {
    super.initState();
    // fetchCryptoData();
    fetchTodayCryptoPrice(
        Provider.of<TradeValueState>(context, listen: false).bitcoin,
        "bitcoin");
    fetchTodayCryptoPrice(
        Provider.of<TradeValueState>(context, listen: false).ethereum,
        "ethereum");
    fetchTodayCryptoPrice(
        Provider.of<TradeValueState>(context, listen: false).tether, "tether");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "Trade Coins",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
              Text("Click any coin to start trading"),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              SizedBox(height: 15),
              Text(
                "All Coins",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CryptoPriceChart(
                                cryptocurrencyName: 'bitcoin',
                                cryptoData: Provider.of<TradeValueState>(
                                        context,
                                        listen: false)
                                    .bitcoin,
                              ),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              "public/images/bitcoin-removebg-preview.png",
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text("Bitcoin",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 5),
                                Text("BTC",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100))
                              ],
                            )
                          ]),
                          Column(
                            children: [
                              Text("\$${btcCurrentMarketPrice.toString()}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              // Row(
                              //   children: [
                              //     Transform.rotate(
                              //       angle:
                              //           -0.2, // Adjust the angle to get the desired curve
                              //       child: Icon(
                              //         Icons.arrow_downward,
                              //         color: Colors.redAccent,
                              //         size: 18, // Adjust the size as needed
                              //       ),
                              //     ),
                              //     Text("0.20%",
                              //         style: TextStyle(
                              //             color: Colors.redAccent,
                              //             fontSize: 10,
                              //             fontWeight: FontWeight.w600))
                              //   ],
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoPriceChart(
                                cryptocurrencyName: 'ethereum',
                                cryptoData: Provider.of<TradeValueState>(
                                        context,
                                        listen: false)
                                    .ethereum),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              "public/images/Ethereum-logo-removebg-preview.png",
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text("Ethereum",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 5),
                                Text("ETH(ERC20)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100))
                              ],
                            )
                          ]),
                          Column(
                            children: [
                              Text("\$${ethCurrentMarketPrice.toString()}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              // Row(
                              //   children: [
                              //     Transform.rotate(
                              //       angle:
                              //           -0.2, // Adjust the angle to get the desired curve
                              //       child: Icon(
                              //         Icons.arrow_downward,
                              //         color: Colors.redAccent,
                              //         size: 18, // Adjust the size as needed
                              //       ),
                              //     ),
                              //     Text("0.20%",
                              //         style: TextStyle(
                              //             color: Colors.redAccent,
                              //             fontSize: 10,
                              //             fontWeight: FontWeight.w600))
                              //   ],
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoPriceChart(
                                cryptocurrencyName: 'tether',
                                cryptoData: Provider.of<TradeValueState>(
                                        context,
                                        listen: false)
                                    .tether),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              "public/images/tether2-removebg-preview.png",
                              width: 50,
                            ),
                            Column(
                              children: [
                                Text("TETHER",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(height: 5),
                                Text("USDT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w100))
                              ],
                            )
                          ]),
                          Column(
                            children: [
                              Text("\$${tetherCurrentMarketPrice.toString()}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              // Row(
                              //   children: [
                              //     Transform.rotate(
                              //       angle:
                              //           -0.2, // Adjust the angle to get the desired curve
                              //       child: Icon(
                              //         Icons.arrow_downward,
                              //         color: Colors.redAccent,
                              //         size: 18, // Adjust the size as needed
                              //       ),
                              //     ),
                              //     Text("0.20%",
                              //         style: TextStyle(
                              //             color: Colors.redAccent,
                              //             fontSize: 10,
                              //             fontWeight: FontWeight.w600))
                              //   ],
                              // )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
