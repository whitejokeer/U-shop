import 'package:flutter/material.dart';
import 'package:ushop/screens/addPublicacion.dart';
import 'package:ushop/screens/home.dart';
import 'package:ushop/screens/misPublicaciones.dart';
import 'package:ushop/screens/registro.dart';
import 'package:ushop/screens/splash.dart';
import 'screens/widgets/colors.dart';
import 'screens/login.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: _kShrineTheme,
      ),
    );

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    backgroundColor: Colors.blue[50],
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    canvasColor: Colors.blue[50],
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

final routes = {
  '/': (BuildContext context) => new SplashScreen(),
  '/login': (BuildContext context) => new Login(),
  '/registro': (BuildContext context) => new Registro(),
  '/home': (BuildContext context) => new Publicaciones(),
  '/publicaciones': (BuildContext context) => new MisPublicaciones(),
  '/addPublicacion': (BuildContext context) => new AddPublicacion(),
};
