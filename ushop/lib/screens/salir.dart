import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushop/screens/splash.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:ushop/screens/widgets/colors.dart';

class Salir extends StatefulWidget {
  Salir({Key key}) : super(key: key);

  @override
  _SalirState createState() => _SalirState();
}

class _SalirState extends State<Salir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, 'Cerrar Sesion', false),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.lightBlueAccent.shade100,
            elevation: 5.0,
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              color: kShrinePink100,
              child: Text('Salir'),
            ),
          ),
        ),
      ),
    );
  }
}
