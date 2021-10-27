import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitcoin_ticker/screens/price_screen.dart';

const String apikey = '64899729-206E-43A1-9443-2635BFB23EB5';
const String baseUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class Networking {
  Future<dynamic> getCurrencyData(
      String? digitalCurrency, String? realCurrency) async {
    print(
        '=========================Inside Networking=========================');
    print(realCurrency);
    String url = '${baseUrl}$digitalCurrency/$realCurrency?apikey=$apikey';
    print('========================url========================');
    print(url);
    http.Response response = await http.get(Uri.parse(url.toString()));
    var Data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Data;
    } else {
      print(response.statusCode);
    }
  }
}
