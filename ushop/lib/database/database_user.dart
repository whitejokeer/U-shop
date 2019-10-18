import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:ushop/models/carreras.dart';
import 'package:ushop/models/categorias.dart';
import 'package:ushop/models/university.dart';
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
    print("Created User");
    await db.execute(
        "CREATE TABLE Universidades(id_universidad INT, nombre_universidad TEXT, direccion TEXT, ciudad TEXT)");
    print("Created Universidad");
    await db.execute(
        "CREATE TABLE Carreras(id_carrera INT,  id_universidad INT, nombre_carrera TEXT)");
    print("Created Carrera");
    await db.execute(
        "CREATE TABLE Categorias(id_categoria INT, nombre_categoria TEXT)");
  }

  //Funciones para el manejo de la informacion de usuarios

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

    if (maps.length > 0) {
      return User.fromDb(maps.first);
    }
    return null;
  }

  // Informacion para el manejo de la informacion de la universidad

  Future<int> saveUniversidad(Universidad universidad) async {
    var dbClient = await db;
    int res = await dbClient.insert("Universidades", universidad.toMap());
    return res;
  }

  Future<int> deleteUniversidad() async {
    var dbClient = await db;
    int res = await dbClient.delete("Universidades");
    return res;
  }

  Future<List<Universidad>> fetchUniversidades() async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    final List<Map<String, dynamic>> maps =
        await dbClient.query('Universidades');

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return List.generate(maps.length, (i) {
      return Universidad.fromDb(maps[i]);
    });
  }

  Future<Universidad> fetchUniversidad(int id) async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    var data = await dbClient.query('Universidades',
        columns: null, where: 'id_universidad = ?', whereArgs: [id]);

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return Universidad.fromDb(data[0]);
  }

  // Funciones manejo Carreras

  Future<int> saveCarrera(Carrera carrera) async {
    var dbClient = await db;
    int res = await dbClient.insert("Carreras", carrera.toMap());
    return res;
  }

  Future<int> deleteCarreras() async {
    var dbClient = await db;
    int res = await dbClient.delete("Carreras");
    return res;
  }

  Future<List<Carrera>> fetchCarreras() async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    final List<Map<String, dynamic>> maps = await dbClient.query('Carreras');

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return List.generate(maps.length, (i) {
      return Carrera.fromDb(maps[i]);
    });
  }

  Future<Carrera> fetchCarrera(int id) async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    var data = await dbClient.query('Carreras',
        columns: null, where: 'id_carrera = ?', whereArgs: [id]);

    return Carrera.fromDb(data[0]);
  }

  // Funciones manejo de Categorias

  Future<int> saveCategoria(Categoria categoria) async {
    var dbClient = await db;
    int res = await dbClient.insert("Categorias", categoria.toMap());
    return res;
  }

  Future<int> deleteCategorias() async {
    var dbClient = await db;
    int res = await dbClient.delete("Categorias");
    return res;
  }

  Future<List<Categoria>> fetchCategorias() async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    final List<Map<String, dynamic>> maps = await dbClient.query('Categorias');

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return List.generate(maps.length, (i) {
      return Categoria.fromDb(maps[i]);
    });
  }

  Future<Categoria> fetchCategoria(int id) async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    var data = await dbClient.query('Categorias',
        columns: null, where: 'id_categoria = ?', whereArgs: [id]);

    return Categoria.fromDb(data[0]);
  }
}
