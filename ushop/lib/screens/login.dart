import 'package:flutter/material.dart';
import '../controllers/user_request.dart';
import '../database/database_user.dart';
import 'widgets/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  RestDataRequest api = new RestDataRequest();
  String _email, _password;

  ///This should be in a splash screen
  loguedInQuestion() async {
    var db = new DatabaseHelper();
    var isLoggedIn = await db.isLoggedIn();
    if (isLoggedIn) {Navigator.of(context).pushReplacementNamed('/home');}
  }

  void initState() {
    super.initState();
    loguedInQuestion();
  }

  loginRequest() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      api.login(_email, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
        height: 100.0,
        width: 100.0,
        child: Image.asset(
          "assets/2.0x/diamond.png",
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
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _email = val,
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
        onSaved: (val) => _password = val,
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
          onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
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
      onPressed: () {},
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

//Cambia el color de los text box
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}