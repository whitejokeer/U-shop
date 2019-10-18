import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
    ));

final routes = {
  '/': (BuildContext context) => new Login(),
  '/home': (BuildContext context) => new Home(),
};