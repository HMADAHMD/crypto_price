import 'package:http/http.dart' as http;
import 'dart:convert';

var apiKey = '65181247-2D22-47F8-8AB5-260B0511ABB6'; //hammadja01
var apiKey2 = '6C84E161-397D-4CED-95BA-754791DC3038'; //ssgsk

class Networking {
  String URL;
  Networking({required this.URL});
  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(URL));
      String data = response.body;
      return jsonDecode(data);
    } catch (e) {
      print(e);
    }
  }
}
