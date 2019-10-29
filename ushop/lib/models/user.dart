class User {

  ///This are the variables been passing by the json_structure that
  ///matter for the app logic.
  String nombre_usuario, apellido_usuario, profile, fecha_nacimiento, correo, celular, imagen_perfil;
  int id_usuario, sexo, id_universidad, id_carrera;
  ///This helps to transform the json into a user Map structure for
  ///a fast construction.
  User.map(Map<String, dynamic> parsedJson)
      : id_usuario = parsedJson['id_usuario'],
        nombre_usuario = parsedJson['nombre_usuario'],
        apellido_usuario = parsedJson['apellido_usuario'],
        sexo = parsedJson['sexo']?1:0,
        fecha_nacimiento = parsedJson['fecha_nacimiento'],
        correo = parsedJson['correo'],
        id_carrera = parsedJson['id_carrera'],
        id_universidad = parsedJson['id_universidad'],
        celular = parsedJson['celular'],
        imagen_perfil = parsedJson['imagen_perfil'];

  ///Transform the user fields in a map, this is used to pass user info
  ///to the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id_usuario": id_usuario,
      "nombre_usuario": nombre_usuario,
      "apellido_usuario": apellido_usuario,
      "sexo": sexo,
      "fecha_nacimiento": fecha_nacimiento,
      "correo": correo,
      "id_carrera": id_carrera,
      "id_universidad": id_universidad,
      "celular": celular,
      "imagen_perfil": imagen_perfil
    };
  }

  ///Allow to pass the information of the user from the database to the
  ///User class.
  User.fromDb(Map<String, dynamic> parsedJson)
      : id_usuario = parsedJson['id_usuario'],
        nombre_usuario = parsedJson['nombre_usuario'],
        apellido_usuario = parsedJson['apellido_usuario'],
        sexo = parsedJson['sexo']?1:0,
        fecha_nacimiento = parsedJson['fecha_nacimiento'],
        correo = parsedJson['correo'],
        id_carrera = parsedJson['id_carrera'],
        id_universidad = parsedJson['id_universidad'],
        celular = parsedJson['celular'],
        imagen_perfil = parsedJson['imagen_perfil'];
}