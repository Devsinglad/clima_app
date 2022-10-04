import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String url;

  Data({required this.url});

  Future getData() async {
    try {
      var URL = Uri.parse(url);
      var response = await http.get(URL);
      var myData = response.body;
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(myData);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
