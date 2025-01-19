

import 'package:conversor_de_moedas/pages/home.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.amber,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )) ,
      routes: {
        "/": (context)=> Home(),
      },
    );
  }

}