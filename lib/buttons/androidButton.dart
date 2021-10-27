// import 'package:bitcoin_ticker/coin_data.dart';
// import 'package:flutter/material.dart';
// import 'package:bitcoin_ticker/screens/price_screen.dart';

// class{

//  DropdownButton<String> getAndroidDropDownButton() {
//     List<DropdownMenuItem<String>> newCurrencyList = [];
//     for (String item in currenciesList) {
//       newCurrencyList.add(DropdownMenuItem(
//         child: Text(item),
//         value: item,
//       ));
//     }
//     return DropdownButton<String>(
//       items: newCurrencyList,
//       dropdownColor: Colors.blue,
//       value: realCurrency,
//       onChanged: (String? newValue) {
//         setState(() {
//           print(
//               '==============================Inside set state==============================');
//           realCurrency = newValue!;
//           print('realCurrency $realCurrency');
//           updateUi();
//         });
//       },
//     );
//   }

//   DropdownButton<String> getAndroidDropDownButtonForDigital() {
//     List<DropdownMenuItem<String>> newCurrencyListDigital = [];
//     for (String item in cryptoList) {
//       newCurrencyListDigital.add(DropdownMenuItem(
//         child: Text(item),
//         value: item,
//       ));
//     }
//     return DropdownButton<String>(
//       dropdownColor: Colors.blue,
//       items: newCurrencyListDigital,
//       value: digitalCurrency,
//       onChanged: (String? newValue) {
//         setState(() {
//           print(
//               '==============================Inside set state==============================');
//           digitalCurrency = newValue!;
//           print('realCurrency $digitalCurrency');
//           updateUi();
//         });
//       },
//     );
//   }




// }