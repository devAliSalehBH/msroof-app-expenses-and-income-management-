import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Link.dart';

class AuthController {
  Future LoginAuth(url, Map data) async {
    try {
      print(url.toString());
      var res = await http.post(Uri.parse(url), body: data);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        return data;
      } else {
        print("Error ${res.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  Future SignUpAuth(url, Map data) async {
    try {
      print(url.toString());
      var res = await http.post(Uri.parse(url), body: data);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        return data;
      } else {
        print("Error ${res.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  Future DeleteIncom(url, Map data) async {
    try {
      var res = await http.post(Uri.parse(url), body: data);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        return data;
      } else {
        print("error ${res.statusCode}");
      }
    } catch (e) {
      print("error catch$e");
    }
  }
}
