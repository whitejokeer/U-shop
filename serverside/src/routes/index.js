const { Router } = require('express');
const router = Router();

const { logeo,
    addUser,
    publicaciones,
    misPublicaciones,
    addPublicacion,
    editPublicacion,
    borrarPublicacion,
    getUniversidades,
    getCarreras,
    getCategorias } = require('../controllers/index.controller');

router.get('/', (req, res) => {
    res.send("https://firebasestorage.googleapis.com/v0/b/u-shop-531b8.appspot.com/o/app.apk?alt=media&token=8ebf10ad-eb1f-400b-8311-09191e3c256a");
})

// Peticiones principal_request
router.get('/universidades', getUniversidades);
router.get('/carreras', getCarreras);
router.get('/categorias', getCategorias);

// Peticiones user_request
router.post('/logeo', logeo);
router.post('/addUser', addUser);

// Peticiones publicaciones_request
router.get('/publicaciones', publicaciones);
router.get('/mispublicaciones/:id', misPublicaciones);
router.post('/addpubliacion', addPublicacion);
router.post('/editpublicacion/:id', editPublicacion);
router.delete('/borrarpublicacion/:id', borrarPublicacion);


module.exports = router;