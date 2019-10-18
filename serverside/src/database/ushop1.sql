CREATE DATABASE "ushop1" WITH TEMPLATE = template0;

\connect "dbname='ushop1'"

SET client_encoding
= 'UTF8';

COMMENT ON DATABASE "ushop1" IS 'Base de datos U-SHOP';

CREATE TABLE universidades
(
    id_universidad SERIAL PRIMARY KEY,
    nombre_universidad VARCHAR(64),
    direccion VARCHAR(64),
    ciudad VARCHAR(64)
);

CREATE TABLE carreras
(
    id_carrera SERIAL PRIMARY KEY,
    id_universidad SERIAL REFERENCES universidades,
    nombre_carrera VARCHAR(64)
);

CREATE TABLE usuarios
(
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(64),
    apellido_usuario VARCHAR(64),
    sexo BOOLEAN,
    fecha_nacimiento DATE,
    correo VARCHAR(64),
    contrasena VARCHAR(128),
    id_carrera SERIAL REFERENCES carreras,
    id_universidad SERIAL REFERENCES universidades,
    celular VARCHAR(16),
    imagen_perfil VARCHAR(256),
    estado BOOLEAN
);

CREATE TABLE Categorias
(
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(32),
);

CREATE TABLE publicaciones
(
    id_publicacion SERIAL PRIMARY KEY,
    nombre_publicacion VARCHAR(32),
    descripcion VARCHAR(128),
    precio INTEGER,
    estado BOOLEAN,
    id_usuario SERIAL REFERENCES usuarios,
    imagen_publicacion VARCHAR(256),
    id_categoria INTEGER
);



INSERT INTO universidades
    (nombre_universidad, direccion, ciudad)
VALUES
    ('Universidad Pontificia Bolivariana seccional Bucaramanga', 'via piedecuesta', 'floridablanca');

INSERT INTO carreras
    (id_universidad, nombre_carrera)
VALUES
    (1, 'sistemas');

Insert INTO usuarios
    (nombre_usuario, apellido_usuario, sexo, fecha_nacimiento, correo, contrasena, id_carrera, id_universidad, celular, imagen_perfil, estado)
VALUES(
        'Jairo',
        'Sanchez',
        True,
        '25/12/1995',
        'jairosr_1995@hotmail.com',
        'jairoprueba',
        1,
        1,
        '3138674751',
        'https://www.infobae.com/new-resizer/4nEEHHVs5-II9SXlh4b4DI34iU4=/750x0/filters:quality(100)/s3.amazonaws.com/arc-wordpress-client-uploads/infobae-wp/wp-content/uploads/2018/05/01181948/05-Salma-Hayek.jpg', TRUE);