import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static const _key = '67604B29-A8E8-47EA-9B2C-E770B02643C4';

  Future<double> getRate(String currency) async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[0]}/$currency?apikey=$_key';
    var response = await http.get(Uri.parse(url));
    var amount = json.decode(response.body)['rate'];
    return amount;
  }

  Future<double> getRateEth(String currency) async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[1]}/$currency?apikey=$_key';
    var response = await http.get(Uri.parse(url));
    var amount = json.decode(response.body)['rate'];
    return amount;
  }

  Future<double> getRateTh(String currency) async {
    var url = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[2]}/$currency?apikey=$_key';
    var response = await http.get(Uri.parse(url));
    var amount = json.decode(response.body)['rate'];
    return amount;
  }


}
