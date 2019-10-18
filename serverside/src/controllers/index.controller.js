const { Pool } = require('pg');

const pool = new Pool({
    host: 'localhost',
    user: 'inte',
    password: 'integrador',
    database: 'ushop1',
    port: '5432'
});

const logeo = async (req, res) => {
    const { correo, contrasena} = req.body;
    const respuesta = await pool.query('SELECT * FROM usuarios WHERE correo = $1 AND contrasena = $2;', [correo, contrasena]);
    res.status(200).json(respuesta.rows);
}

const addUser = async (req, res) => {
    const { nombre, apellido, sexo, nacimiento, correo, contrasena, carrera, universidad, celular, foto, estado } = req.body;
    const response = await pool.query(
        'Insert INTO usuarios (nombre_usuario, apellido_usuario, sexo, fecha_nacimiento, correo, contrasena, id_carrera, id_universidad, celular, imagen_perfil, estado) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)',
        [nombre, apellido, sexo, nacimiento, correo, contrasena, carrera, universidad, celular, foto, estado]
    ).catch((e) => {
        console.log(e);
    });
    res.status(200).json({
        message: 'User Agregado',
        body:{
            user: response.rows
        }
    });
}

const infoUser = async (req,res) => {
    const id = parseInt(req.params.id);
    const response = await pool.query('SELECT * FROM usuarios WHERE id_usuario = $1', [id]);
    res.json(response.rows);
}

const publicaciones = async (req, res) => {
    const response = await pool.query('SELECT * FROM publicaciones WHERE estado = TRUE ORDER BY id ASC');
    res.status(200).json(response.rows);
}

const misPublicaciones = async (req, res) => {
    const id = parseInt(req.params.id);
    const response = await pool.query('SELECT * FROM publicaciones WHERE id = $1 AND estado = TRUE', [id]);
    res.json(response.rows);
}

const addPublicacion = async (req, res) => {
    const { name, descripcion, precio, id, estado, imagen } = req.body;
    const response = await pool.query('INSERT INTO publicaciones (nombre_publicacion, descripcion, precio, estado, id_usuario, imagen_publicacion) VALUES ($1, $2, $3, $4, $5, $6)',
    [name, descripcion, precio, estado, id, imagen]);
    res.json({
        message: 'User Added successfully',
        body: {
            user: {name, precio}
        }
    })
}

const editPublicacion = async (req, res) => {
    const id = parseInt(req.params.id);
    const { id_publicacion, name, descripcion, precio, imagen } = req.body;
    const response =await pool.query('UPDATE publicaciones SET nombre_publicacion = $2, descripcion = $3, precio = $4, estado = TRUE, id_usuario = &6, imagen_publicacion = &7 WHERE id = $1', 
    [id_publicacion, name, descripcion, precio, id, imagen]);
    res.json('User Updated Successfully');
}

const borrarPublicacion = async (req, res) => {
    const id = parseInt(req.params.id);
    await pool.query('UPDATE publicaciones SET estado = FALSE where id = $1', [
        id
    ]);
    res.json({
        message: 'Publicacion elimidada correctamente'
    });
}
module.exports = {
    logeo,
    addUser,
    infoUser,
    publicaciones,
    misPublicaciones,
    addPublicacion,
    editPublicacion,
    borrarPublicacion
}