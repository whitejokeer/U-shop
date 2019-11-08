import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ushop/database/database_user.dart';
import 'package:ushop/models/carreras.dart';
import 'package:ushop/models/university.dart';
import 'package:ushop/screens/home.dart';
import 'package:ushop/screens/unitClass/emailValidator.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ushop/screens/widgets/colors.dart';
import 'package:ushop/screens/widgets/errorPopUP.dart';
import 'package:ushop/screens/widgets/textBoxColor.dart';
import 'package:ushop/screens/widgets/uploadButton.dart';

Future<List<Universidad>> fetchUniversidadesFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Universidad>> universidades = dbHelper.fetchUniversidades();
  return universidades;
}

Future<List<Carrera>> fetchCarrerasFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Carrera>> carreras = dbHelper.fetchCarreras();
  return carreras;
}

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final formKey = new GlobalKey<FormState>();
  File _image;
  String _nombre,
      _apellido,
      _celular,
      _sexo,
      _sex,
      _correo,
      foto,
      _contrasena,
      _contrasena2;
  Universidad universidad1;
  List<Universidad> universidades = [];
  Carrera carrera1;
  List<Carrera> carreras = [];
  List<Carrera> opcionesCarreras = [];
  DateTime _edad = DateTime.now();

  getData() async {
    var uni = await fetchUniversidadesFromDatabase();
    var carr = await fetchCarrerasFromDatabase();
    setState(() {
      universidades = uni;
      carreras = carr;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Widget selectImage() {
    return GestureDetector(
      onTap: chooseFile,
      child: _image == null
          ? Image.asset(
              'assets/non_profile.jpg',
              height: 150,
            )
          : Image.file(
              _image,
              height: 150,
            ),
    );
  }

  // String emailValidator(String value) {
  //   Pattern pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Formato de email invalido';
  //   } else {
  //     return null;
  //   }
  // }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'La Contraseña debe tener minimo 8 caracteres';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrar = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              if (_contrasena == _contrasena2) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _correo, password: _contrasena)
                    .then((currentUser) async {
                  foto = await uploadFile(_image, 'usuario');
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.user.uid)
                      .setData({
                        "id_usuario": currentUser.user.uid,
                        "nombre_usuario": _nombre,
                        "apellido_usuario": _apellido,
                        "sexo": _sexo,
                        "fecha_nacimiento": _edad,
                        "email": _correo,
                        "password": _contrasena,
                        "id_carrera": carrera1.id_carrera,
                        "id_universidad": universidad1.id_universidad,
                        "celular": _celular,
                        "imagen_perfil": foto,
                        "estado": true
                      })
                      .then((result) => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Publicaciones(
                                          uid: currentUser.user.uid,
                                          celular: _celular,
                                        )),
                                (_) => false),
                          })
                      .catchError((err) => print(err));
                }).catchError((err) => errorAlert(context, err.toString()));
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Las Contraseñas no coinciden"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              }
            }
          },
          color: kShrinePink100,
          child: Text('Registrar'),
        ),
      ),
    );

    final nombre = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          validator: (val) {
            return val.isEmpty ? "Este campo es obligatorio" : null;
          },
          onSaved: (val) => _nombre = val,
          decoration: InputDecoration(
            labelText: 'Nombre',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final apellido = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          validator: (val) {
            return val.isEmpty ? "Este campo es obligatorio" : null;
          },
          onSaved: (val) => _apellido = val,
          decoration: InputDecoration(
            labelText: 'Apellido',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final celular = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: false,
          validator: (val) {
            return val.isEmpty ? "Este campo es obligatorio" : null;
          },
          onSaved: (val) => _celular = val,
          decoration: InputDecoration(
            labelText: 'Celular',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final sexo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: <Widget>[
              Text("Sexo:  "),
              new DropdownButton<String>(
                hint: new Text("-Seleccionar-"),
                value: _sexo,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    _sexo = newValue;
                    if (_sexo == 'Hombre') {
                      _sex = 'true';
                    } else {
                      _sex = 'false';
                    }
                  });
                },
                icon: new Icon(Icons.arrow_drop_down,
                    size: 30.0,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.white70),
                items: <String>['Hombre', 'Mujer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 180.0,
                      child: new Text(
                        value,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: new TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );

    final correo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          validator: EmailFieldValidator.validate,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          onSaved: (val) => _correo = val,
          decoration: InputDecoration(
            labelText: 'Correo',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final contrasena = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: AccentColorOverride(
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
          ),
        ),
      ),
    );

    final contrasena2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          validator: (val) {
            return val.isEmpty ? "Este campo es obligatorio" : null;
          },
          onSaved: (val) => _contrasena2 = val,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final edad = Align(
      alignment: Alignment.centerLeft,
      child: new Padding(
        padding: new EdgeInsets.only(left: 5.0, top: 15.0),
        child: MaterialButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () {
            DatePicker.showDatePicker(context, showTitleActions: true,
                onConfirm: (date) {
              setState(() {
                _edad = date;
              });
            }, currentTime: DateTime.now(), locale: LocaleType.es);
          },
          child: Wrap(
            children: <Widget>[
              Text(
                'Fecha de nacimiento:       ',
                style: TextStyle(color: kShrineBrown900),
              ),
              Text('${_edad.day}-${_edad.month}-${_edad.year}'),
            ],
          ),
        ),
      ),
    );

    final universidad = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text("Universidad: "),
          new DropdownButton<Universidad>(
            hint: new Text(
              "Universidad",
              overflow: TextOverflow.ellipsis,
            ),
            value: universidad1,
            onChanged: (Universidad newValue) {
              setState(() {
                universidad1 = newValue;
                opcionesCarreras = [];
                for (var i = 0; i < carreras.length; i++) {
                  if (carreras[i].id_universidad ==
                      universidad1.id_universidad) {
                    opcionesCarreras.add(carreras[i]);
                  }
                }
                carrera1 = opcionesCarreras[0];
              });
            },
            icon: new Icon(Icons.arrow_drop_down,
                size: 20.0,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
            items: universidades.map((Universidad univ) {
              return new DropdownMenuItem<Universidad>(
                value: univ,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 120.0,
                  child: new Text(
                    univ.nombre_universidad,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: new TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );

    final carrera = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text("Carrera: "),
          new DropdownButton<Carrera>(
            hint: new Text("Carrera"),
            value: carrera1,
            onChanged: (Carrera newValue) {
              setState(() {
                carrera1 = newValue;
              });
            },
            items: opcionesCarreras.map((Carrera car) {
              return new DropdownMenuItem<Carrera>(
                value: car,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100.0,
                  child: new Text(
                    car.nombre_carrera,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: new TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ); // Barra de opciones Carreras

    return Scaffold(
      appBar: generalAppBar(context, "Regisrate", false),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: selectImage()),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      nombre,
                      apellido,
                      celular,
                      sexo,
                      correo,
                      contrasena,
                      contrasena2,
                      edad,
                    ],
                  ),
                ),
                universidad,
                carrera,
                registrar,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
