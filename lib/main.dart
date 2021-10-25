import 'dart:io';

import 'package:flutter/material.dart';

import 'app.dart';


void main(){
  //debugPaintSizeEnabled = true;
  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

  }


}