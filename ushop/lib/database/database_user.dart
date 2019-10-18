import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import '../models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    ///Change the name of the db field
    String path = join(documentsDirectory.path, "user.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  ///Change the TABLE name and content according to your needs
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id_usuario INT, nombre_usuario TEXT, apellido_usuario TEXT, sexo INT, fecha_nacimiento TEXT, correo TEXT, contrasena TEXT, id_carrera INT, id_universidad INT, celular TEXT, imagen_perfil TEXT )");
    print("Created tables");
    await db.execute(
        "CREATE TABLE Universidades(id_universidad INT, nombre_universidad TEXT, direccion TEXT, ciudad TEXT");
    print("Created tables");
    await db.execute(
        "CREATE TABLE Carreras(id_carrera INT,  id_universidad INT, nombre_carrera INT");
    print("Created tables");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  ///This funtion allows to see if someone is already logued in.
  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("User");
    return res.length > 0 ? true : false;
  }

  Future<User> fetchItem() async {
    List<Map> maps = await _db.rawQuery('SELECT * FROM User');

    if(maps.length > 0) {
      return User.fromDb(maps.first);
    }
    return null;
  }
}