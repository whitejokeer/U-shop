import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ushop/controllers/principal_requests.dart';
import 'package:ushop/database/database_user.dart';
import 'package:ushop/models/categorias.dart';
import 'package:ushop/screens/misPublicaciones.dart';
import 'package:ushop/screens/widgets/appBar.dart';
import 'package:ushop/screens/widgets/colors.dart';
import 'package:ushop/screens/widgets/textBoxColor.dart';
import 'package:ushop/screens/widgets/uploadButton.dart';

Future<List<Categoria>> fetchCategoriasFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Categoria>> categorias = dbHelper.fetchCategorias();
  return categorias;
}

class AddPublicacion extends StatefulWidget {
  final String celular, uid;
  AddPublicacion({Key key, this.celular, this.uid}) : super(key: key);

  @override
  _AddPublicacionState createState() => _AddPublicacionState();
}

class _AddPublicacionState extends State<AddPublicacion> {
  final formKey = new GlobalKey<FormState>();
  String _imagen_publicacion, _precio, _nombre_publicacion, _descripcion, ip;
  File _image;
  Categoria _categoria;
  List<Categoria> categorias = [];
  RestPrincipalRequest api2 = new RestPrincipalRequest();

  installPrincipales() async {
    await Firestore.instance.collection('url').document('1').get().then((res)=> ip = res.data['url']);
    print(ip);
    await api2.infoNecesaria('http://${ip}:8080');
    print("Se realizo con exito");
  }

  getData() async {
    var cat = await fetchCategoriasFromDatabase();
    setState(() {
      categorias = cat;
      _categoria = categorias[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final publicar = Padding(
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
              if (_image != null) {
                formKey.currentState.save();
                _imagen_publicacion = await uploadFile(_image, 'publicacion');
                Firestore.instance
                    .collection(_categoria.nombre_categoria)
                    .add({
                      "celular": widget.celular,
                      "descripcion": _descripcion,
                      "imagen_publicacion": _imagen_publicacion,
                      "nombre_publicacion": _nombre_publicacion,
                      "precio": _precio,
                    })
                    .then((result) => {
                          Firestore.instance
                              .collection('users')
                              .document(widget.uid)
                              .collection('Publicaciones')
                              .document(result.documentID)
                              .setData({
                            "categoria": _categoria.nombre_categoria,
                            "celular": widget.celular,
                            "descripcion": _descripcion,
                            "imagen_publicacion": _imagen_publicacion,
                            "nombre_publicacion": _nombre_publicacion,
                            "precio": _precio,
                          }).then((res) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MisPublicaciones(
                                          uid: widget.uid,
                                          celular: widget.celular,
                                        )),
                                (_) => false);
                          }).catchError((err) => print(err))
                        })
                    .catchError((err) => print(err));
              }
            }
          },
          color: kShrinePink100,
          child: Text('Publicar'),
        ),
      ),
    );

    Future chooseFile() async {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _image = image;
      setState(() {});
    }

    Widget selectImage() {
      return GestureDetector(
        onTap: chooseFile,
        child: _image == null
            ? Icon(
                Icons.add_photo_alternate,
                size: 180.00,
                color: grisAppbar,
              )
            : Image.file(
                _image,
                height: 150,
              ),
      );
    }

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
          onSaved: (val) => _nombre_publicacion = val,
          decoration: InputDecoration(
            labelText: 'Nombre de la publicacion',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final categoriaSelect = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text("Carrera: "),
          new DropdownButton<Categoria>(
            hint: new Text("Tipo de Cita"),
            value: _categoria,
            onChanged: (Categoria newValue) {
              setState(() {
                _categoria = newValue;
              });
            },
            items: categorias.map((Categoria car) {
              return new DropdownMenuItem<Categoria>(
                value: car,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100.0,
                  child: new Text(
                    car.nombre_categoria,
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

    final precio = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          validator: (val) {
            return val.isEmpty ? "Este campo es obligatorio" : null;
          },
          onSaved: (val) => _precio = val,
          decoration: InputDecoration(
            labelText: 'Precio',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    final descripcion = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AccentColorOverride(
        color: kShrineBrown900,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          onSaved: (val) => _descripcion = val,
          decoration: InputDecoration(
            labelText: 'Descripcion',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: generalAppBar(context, "Agregar Publicacion", false),
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
                      categoriaSelect,
                      precio,
                      descripcion
                    ],
                  ),
                ),
                publicar,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
