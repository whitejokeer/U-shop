import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ushop/controllers/principal_requests.dart';
import 'package:ushop/screens/home.dart';
import 'package:ushop/screens/widgets/textBoxColor.dart';
import 'widgets/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  RestPrincipalRequest api2 = new RestPrincipalRequest();
  String _correo, _contrasena, ip;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
        height: 100.0,
        width: 100.0,
        child: Image.asset(
          "assets/diamond.png",
        ));
    final name = Center(
      child: Text(
        "U-SHOP",
        style: TextStyle(
            fontSize: 50.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Hind',
            fontWeight: FontWeight.bold),
      ),
    );

    final email = AccentColorOverride(
      color: kShrineBrown900,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: emailValidator,
        onSaved: (val) => _correo = val,
        decoration: InputDecoration(
          labelText: 'Correo',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final password = AccentColorOverride(
      color: kShrineBrown900,
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _contrasena = val,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _correo, password: _contrasena)
                  .then((currentUser) => Firestore.instance
                      .collection("users")
                      .document(currentUser.user.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Publicaciones(
                                        uid: currentUser.user.uid,
                                        celular: result.data['celular'],
                                      ))))
                      .catchError((err) => print(err)))
                  .catchError((err) => print(err));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("The passwords do not match"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }
          },
          color: kShrinePink100,
          child: Text('Ingresar'),
        ),
      ),
    );

    final registerLabel = FlatButton(
      child: Text(
        'No tines cuenta? Registrate',
        style: TextStyle(color: Color(0xff99bcea)),
      ),
      onPressed: () => Navigator.of(context).pushNamed('/registro'),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            name,
            SizedBox(height: 70.0),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  email,
                  SizedBox(height: 12.0),
                  password,
                ],
              ),
            ),
            SizedBox(height: 24.0),
            loginButton,
            registerLabel
          ],
        ),
      ),
    );
  }
}
