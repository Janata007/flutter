import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ss/src/ui/home_page.dart';
import 'package:ss/src/ui/login_page.dart';

class App extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      routes: routes,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LoginPage(),
      ),
    );
  }
}
