class Universidad {
  final int id_universidad;
  final String nombre_universidad, direccion, ciudad;

  ///This helps to transform the json into a user Map structure for
  ///a fast construction.
  Universidad.map(Map<String, dynamic> parsedJson)
      : id_universidad = parsedJson['id_universidad'],
        nombre_universidad = parsedJson['nombre_universidad'],
        direccion = parsedJson['direccion'],
        ciudad = parsedJson['ciudad'];

  ///Transform the user fields in a map, this is used to pass user info
  ///to the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_universidad': id_universidad,
      'nombre_universidad': nombre_universidad,
      'direccion': direccion,
      'ciudad': ciudad
    };
  }

  ///Allow to pass the information of the user from the database to the
  ///User class.
  Universidad.fromDb(Map<String, dynamic> parsedJson)
      : id_universidad = parsedJson['id_universidad'],
        nombre_universidad = parsedJson['nombre_universidad'],
        direccion = parsedJson['direccion'],
        ciudad = parsedJson['ciudad'];
}
