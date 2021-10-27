import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:bitcoin_ticker/services/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? rate;

  @override
  void initState() {
    super.initState();
    getCurrencyData();
  }

  void getCurrencyData() async {
    var Data = await Networking().getCurrencyData('BTC', 'USD');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PriceScreen(
                  data: Data,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: SpinKitThreeInOut(
          color: Colors.green,
          size: 32.0,
        ),
      ),
    ));
  }
}
