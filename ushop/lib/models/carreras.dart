class Carrera {
  final int id_carrera, id_universidad;
  final String nombre_carrera;

  ///This helps to transform the json into a user Map structure for
  ///a fast construction.
  Carrera.map(Map<String, dynamic> parsedJson)
      : id_carrera = int.parse(parsedJson['id_carrera']),
        id_universidad = int.parse(parsedJson['id_universidad']),
        nombre_carrera = parsedJson['nombre_carrera'];

  ///Transform the user fields in a map, this is used to pass user info
  ///to the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_carrera': id_carrera,
      'id_universidad': id_universidad,
      'nombre_carrera': nombre_carrera
    };
  }

  ///Allow to pass the information of the user from the database to the
  ///User class.
  Carrera.fromDb(Map<String, dynamic> parsedJson)
      : id_carrera = int.parse(parsedJson['id_carrera']),
        id_universidad = int.parse(parsedJson['id_universidad']),
        nombre_carrera = parsedJson['nombre_carrera'];
}
