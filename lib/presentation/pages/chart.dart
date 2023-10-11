import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import '../theme/main_theme.dart';
import '../../services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgpaypoint/data/models/trade_value.dart';
import '../routes.dart';

class TimeSeriesSales {
  final DateTime time;
  final double price;

  TimeSeriesSales(this.time, this.price);
}

class CryptoPriceChart extends StatefulWidget {
  final String cryptocurrencyName;
  final TradeValue? cryptoData;

  CryptoPriceChart(
      {required this.cryptocurrencyName, required this.cryptoData});

  @override
  _CryptoPriceChartState createState() => _CryptoPriceChartState();
}

class _CryptoPriceChartState extends State<CryptoPriceChart> {
  AllTheme sgtheme = AllTheme();
  List<TimeSeriesSales> priceData = [];
  Services api = Services();

  Future<void> fetchCryptoPriceData() async {
    if (widget.cryptoData != null) {
      //check if the crypto data is available else fetch
      for (var entry in widget.cryptoData!.data) {
        final timestamp =
            DateTime.fromMillisecondsSinceEpoch(entry['time'].toInt() * 1000);

        final price = double.parse(entry['priceUsd']);

        setState(() {
          priceData.add(TimeSeriesSales(timestamp, price));
        });
      }
    } else {
      try {
        final historyData = (await api.Get(
                'https://api.coincap.io/v2/assets/${widget.cryptocurrencyName}/history?interval=d1'))[
            'data'];

        for (var entry in historyData) {
          final timestamp =
              DateTime.fromMillisecondsSinceEpoch(entry['time'].toInt() * 1000);

          final price = double.parse(entry['priceUsd']);

          setState(() {
            priceData.add(TimeSeriesSales(timestamp, price));
          });
        }
      } catch (err) {
        Fluttertoast.showToast(
            msg: "Failed in retrieving ${widget.cryptocurrencyName} data");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.cryptoData);
    fetchCryptoPriceData();
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.price,
        data: priceData,
      ),
    ];

    var chart = charts.TimeSeriesChart(
      series,
      animate: true,
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(format: 'd', transitionFormat: 'MM/dd'),
        ),
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "${widget.cryptocurrencyName.toUpperCase()} DAILY CHART",
                style: TextStyle(
                  color: sgtheme.cutomDarkColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: chart),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.sell_crypto);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: sgtheme.cutomDarkColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("TRADE CRYPTO",
                        style: TextStyle(color: Colors.white)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
