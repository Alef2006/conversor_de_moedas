import 'package:conversor_de_moedas/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=82465bb4";

void main()  {
  runApp(App());
}

Future<Map> requestApiHgFinance() async {
  http.Response response = await http.get( Uri.parse('https://corsproxy.io/?https://api.hgbrasil.com/finance?key=6ecc4f91'));

  return json.decode(response.body);
}
