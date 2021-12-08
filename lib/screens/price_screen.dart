import 'dart:io' show Platform;

import 'package:bitcoin_ticker/helpers/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coindata = CoinData();
  double amountBTC = 0.0;
  double amountEth = 0.0;
  double amountTh = 0.0;
  String _selectedCurr = 'USD';

  Future<void> getCurrRate(String curr) async {
    var res = await coindata.getRate(curr);
    var res2 = await coindata.getRateEth(curr);
    var res3 = await coindata.getRateTh(curr);
    setState((){
      amountBTC = res.roundToDouble();
      amountEth = res2.roundToDouble();
      amountTh = res3.roundToDouble();
    });
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> _items = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      _items.add(newItem);
    }

    return DropdownButton<String>(
      value: _selectedCurr,
      items: _items,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCurr = newValue!;
          getCurrRate(_selectedCurr);
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> _items = [];
    for (String curr in currenciesList) {
      _items.add(
        Text(
          curr,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        setState(() {
          getCurrRate(currenciesList[selectedIndex]);
          _selectedCurr = currenciesList[selectedIndex];
        });
      },
      children: _items,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrRate(_selectedCurr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children:[
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
                    '1 BTC = $amountBTC $_selectedCurr',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
                      '1 ETH = $amountEth $_selectedCurr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                      '1 LTC = $amountTh $_selectedCurr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: !Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
