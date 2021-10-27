import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

//.mergewith (refer)[to add somting to style constant]

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

  void updateUi() async {
    print('=====================UpdateUi====================');
    updatedData =
        await Networking().getCurrencyData(digitalCurrency, realCurrency);
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
      dropdownColor: Colors.blue,
      value: realCurrency,
      onChanged: (String? newValue) {
        setState(() {
          print(
              '==============================Inside set state==============================');
          realCurrency = newValue!;
          print('realCurrency $realCurrency');
          updateUi();
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
      dropdownColor: Colors.blue,
      items: newCurrencyListDigital,
      value: digitalCurrency,
      onChanged: (String? newValue) {
        setState(() {
          print(
              '==============================Inside set state==============================');
          digitalCurrency = newValue!;
          print('realCurrency $digitalCurrency');
          updateUi();
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
        updateUi();
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
        updateUi();
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
                    ? getIosPickerForDigital()
                    : getAndroidDropDownButtonForDigital(),
              ),
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width * .5,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS
                    ? getIosPicker()
                    : getAndroidDropDownButton(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
