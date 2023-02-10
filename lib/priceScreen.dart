import 'dart:io';
import 'package:bitcoin_price_/Networking.dart';
import 'package:bitcoin_price_/coinData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}
String? _selectedItem = 'USD';
int selectedIndex = 0;
String selected_Item = currenciesList[selectedIndex];
var apiKey3 = "1988F801-EF4A-4C34-9C19-898ED76A1BF3";

class _PriceScreenState extends State<PriceScreen> {
  
  CoinData mydata = CoinData();
  var btc_price;
  var eth_price;
  var ltc_price;

  @override
  void initState() {
    super.initState();
    coinPrice();
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
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: BTCprice(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.purple[300],
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Ethprice(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.green[300],
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Ltcprice(),
                      ),
                    ),
                  ),
                ]),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: iOSPicker(),
            ),
          ],
        ));
  }
}

extension Widgets on _PriceScreenState {
  DropdownButton<String> androidMenu() {
    //drop_down_menu item function
    return DropdownButton<String>(
      value: _selectedItem,
      items: [
        for (var i = 0; i < currenciesList.length; i++)
          DropdownMenuItem(
            child: Text('${currenciesList[i]}'),
            value: '${currenciesList[i]}',
          ),
      ],
      onChanged: ((value) {
        setState(() {
          _selectedItem = value!;
        });
      }),
    );
  }

  Widget getwidget() {
    return Platform.isIOS ? iOSPicker() : androidMenu();
  }

  CupertinoPicker iOSPicker() {
    List<Text> mylist = [];
    for (String currency in currenciesList) {
      Text(currency);
      mylist.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int index) {
        print("${currenciesList[index]}");
        setState(() {
          selectedIndex = index;
          selected_Item = currenciesList[index];
          coinPrice();
        });
      },
      children: mylist,
    );
  }
}

extension Networks on _PriceScreenState {
  Future getBTCData() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/$selected_Item/?apiKey=$apiKey3";
    Networking mynetworking = Networking(URL: url);
    var returnedData = await mynetworking.getData();
    return returnedData;
  }

  Future getETHData() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/ETH/$selected_Item/?apiKey=$apiKey3";
    Networking mynetworking = Networking(URL: url);
    var returnedData = await mynetworking.getData();
    return returnedData;
  }

  Future getLTCData() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/LTC/$selected_Item/?apiKey=$apiKey3";
    Networking mynetworking = Networking(URL: url);
    var returnedData = await mynetworking.getData();
    return returnedData;
  }

  void coinPrice() async {
    var btc_received = await getBTCData();
    var eth_received = await getETHData();
    var ltc_received = await getLTCData();
    setState(() async {
      var bprice = btc_received['rate'];
      var eprice = eth_received['rate'];
      var lprice = ltc_received['rate'];
      btc_price = bprice.toInt();
      eth_price = eprice.toInt();
      ltc_price = lprice.toInt();
      BTCprice();
      Ethprice();
      Ltcprice();
    });
  }

  Widget BTCprice() {
    return Text(
      '1 BTC = $btc_price $selected_Item',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ), // this is not good doing in stuff like that will
    );
  }

  Widget Ethprice() {
    return Text(
      '1 ETH = $eth_price $selected_Item',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ), // this is not good doing in stuff like that will
    );
  }

  Widget Ltcprice() {
    return Text(
      '1 LTC = $ltc_price $selected_Item',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ), // this is not good doing in stuff like that will
    );
  }
}
// CupertinoPicker iOSPicker() {
//   List<Text> mylist = [];
//   for (String currency in currenciesList) {
//     Text(currency);
//     mylist.add(Text(currency));
//   }
//   return CupertinoPicker(
//     backgroundColor: Colors.lightBlue,
//     itemExtent: 32.0,
//     onSelectedItemChanged: (int index) {
//       print("${currenciesList[index]}");
//     },
//     children: mylist,
//   );
// }
