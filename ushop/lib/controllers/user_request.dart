import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:ushop/database/database_user.dart';
import 'package:ushop/models/user.dart';
import 'package:ushop/screens/widgets/errorPopUP.dart';
import '../screens/widgets/url.dart';

class RestUserRequest {
  login(BuildContext context, String correo, String contrasena) async {
    Dio dio = new Dio();

    dio.options.baseUrl = urlPrincipal; //url del servidor
    dio.options.connectTimeout = 5000; // 5 segundos
    dio.options.receiveTimeout = 5000; // 3 segundos

    FormData formData = new FormData.fromMap({
      "correo": correo,
      "contrasena": contrasena
    }); // Formato del json entregado.

    Response response =
        await dio.post("/login", data: formData); // configuracion del endpoint

    var dataMap = response.data; // Accedemos al manejo del json retornado

    // Validamos la correcta respuesta de la informacion antes de ingresarlo a la base de datos.
    if (dataMap['message'] == "User Autenticado") {
      var dba = DatabaseHelper();
      final _user = User.map(dataMap['body']);
      await dba.deleteUsers();
      await dba.saveUser(_user);
      Navigator.of(context).pushReplacementNamed('/Home');
    } else {
      errorAlert(context, "El Usuario o Contraseña no son correctos");
    }
  }

  registrarse(
      BuildContext context,
      String nombre,
      String apellido,
      int sexo,
      DateTime nacimiento,
      String correo,
      String contrasena,
      int carrera,
      int universidad,
      String celular,
      String foto) async {
    Dio dio = new Dio();

    dio.options.baseUrl = urlPrincipal; //url del servidor
    dio.options.connectTimeout = 5000; // 5 segundos
    dio.options.receiveTimeout = 5000; // 3 segundos

    FormData formData = new FormData.fromMap({
      "nombre": nombre,
      "apellido": apellido,
      "sexo": sexo,
      "nacimiento": nacimiento,
      "correo": correo,
      "contrasena": contrasena,
      "carrera": carrera,
      "universidad": universidad,
      "celular": celular,
      "foto": foto,
    }); // Formato del json entregado.

    Response response = await dio.post("/addUser",
        data: formData); // configuracion del endpoint

    var dataMap = response.data;// Accedemos al manejo del json retornado

    // Validamos la correcta respuesta de la informacion antes de ingresarlo a la base de dato
    if (dataMap['message'] == "User Agregado") {
      var dba = DatabaseHelper();
      final _user = User.map(dataMap['body']);
      await dba.deleteUsers();
      await dba.saveUser(_user);
      Navigator.of(context).pushReplacementNamed('/Home');
    } else {
      errorAlert(context, "El Correo ya esta registrado");
    }
  }
}
