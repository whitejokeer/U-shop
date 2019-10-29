class Categoria {
  final int id_categoria;
  final String nombre_categoria;

  ///This helps to transform the json into a user Map structure for
  ///a fast construction.
  Categoria.map(Map<String, dynamic> parsedJson)
      : id_categoria = parsedJson['id_categoria'],
        nombre_categoria = parsedJson['nombre_categoria'];

  ///Transform the user fields in a map, this is used to pass user info
  ///to the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_categoria': id_categoria,
      'nombre_categoria': nombre_categoria
    };
  }

  ///Allow to pass the information of the user from the database to the
  ///User class.
  Categoria.fromDb(Map<String, dynamic> parsedJson)
      : id_categoria = int.parse(parsedJson['id_categoria']),
        nombre_categoria = parsedJson['nombre_categoria'];
}
