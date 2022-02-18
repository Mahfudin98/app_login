import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final _url = Uri.parse('https://app-r.lsskincare.id/api/login');

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // ignore: prefer_typing_uninitialized_variables
  var token;

  getToken() async {
    final SharedPreferences localStorage = await _prefs;
    token = localStorage.getString('data');
  }

  auth(data) async {
    // var fullUrl = Uri.parse('$_url' + apiURL);
    return await http.post(
      _url,
      body: jsonEncode(data),
      headers: setHeaders(),
    );
  }

  getData(apiURL) async {
    // var fullUrl = Uri.parse('$_url' + apiURL);
    await getToken();
    return await http.get(
      // fullUrl,
      _url,
      headers: setHeaders(),
    );
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
