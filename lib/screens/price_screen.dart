import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  var data;
  PriceScreen({this.data});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double? rate;
  String? realCurrency = 'USD';
  String? digitalCurrency = 'BTC';
  var updatedData;

  @override
  void initState() {
    super.initState();
    var dummy = widget.data;
    print('dummy Data:---------=> $dummy ');
    widget.data != null ? rate = widget.data['rate'] : rate = 0.0;
  }

  void updateUi(String? real) async {
    print('=====================UpdateUi====================');
    print('real value: $real');
    updatedData = await Networking().getCurrencyData(real, digitalCurrency);
    print('updateData value: $updatedData');
    setState(() {
      updatedData != null ? rate = updatedData['rate'] : rate = 0.0;
      print('rate value: $rate');
    });
  }

  DropdownButton<String> getAndroidDropDownButton() {
    List<DropdownMenuItem<String>> newCurrencyList = [];
    for (String item in currenciesList) {
      newCurrencyList.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return DropdownButton<String>(
      items: newCurrencyList,
      value: realCurrency,
      onChanged: (String? newValue) {
        setState(() {
          print(
              '==============================Inside set state==============================');
          realCurrency = newValue!;
          print('realCurrency $realCurrency');
          updateUi(realCurrency);
        });
      },
    );
  }

  DropdownButton<String> getAndroidDropDownButtonForDigital() {
    List<DropdownMenuItem<String>> newCurrencyListDigital = [];
    for (String item in cryptoList) {
      newCurrencyListDigital.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return DropdownButton<String>(
      items: newCurrencyListDigital,
      value: digitalCurrency,
      onChanged: (String? newValue) {
        setState(() {
          print(
              '==============================Inside set state==============================');
          digitalCurrency = newValue!;
          print('realCurrency $digitalCurrency');
          updateUi(digitalCurrency);
        });
      },
    );
  }

  CupertinoPicker getIosPicker() {
    List<Text> newCurrencyList = [];
    for (String currency in currenciesList) {
      newCurrencyList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (SelectedIndex) {
        realCurrency = SelectedIndex.toString();
        updateUi(realCurrency);
      },
      children: newCurrencyList,
    );
  }

  CupertinoPicker getIosPickerForDigital() {
    List<Text> newCurrencyListDigital = [];
    for (String currency in cryptoList) {
      newCurrencyListDigital.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (SelectedIndex) {
        digitalCurrency = SelectedIndex.toString();
        updateUi(digitalCurrency);
      },
      children: newCurrencyListDigital,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('rate value inside build: $rate');
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $digitalCurrency = $rate $realCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS
                    ? getIosPicker()
                    : getAndroidDropDownButton(),
              ),
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS
                    ? getIosPickerForDigital()
                    : getAndroidDropDownButtonForDigital(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
