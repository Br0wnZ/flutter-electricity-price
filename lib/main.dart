import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:electricity_price/service_locator.dart';

import 'package:electricity_price/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final  Map<int, Color> colorCodes = {
      50: Color.fromRGBO(147, 205, 72, .1),
      100: Color.fromRGBO(147, 205, 72, .2),
      200: Color.fromRGBO(147, 205, 72, .3),
      300: Color.fromRGBO(147, 205, 72, .4),
      400: Color.fromRGBO(147, 205, 72, .5),
      500: Color.fromRGBO(147, 205, 72, .6),
      600: Color.fromRGBO(147, 205, 72, .7),
      700: Color.fromRGBO(147, 205, 72, .8),
      800: Color.fromRGBO(147, 205, 72, .9),
      900: Color.fromRGBO(147, 205, 72, 1),
    };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precio Luz',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff141625, colorCodes),
      ),
      home: SafeArea(child: HomePage()),
    );
  }
}

