const { Router } = require('express');
const router = Router();

const { logeo,
    addUser,
    infoUser,
    publicaciones,
    misPublicaciones,
    addPublicacion,
    editPublicacion,
    borrarPublicacion } = require('../controllers/index.controller');

router.get('/', (req, res) => {
    res.send("USHOP SERVERSIDE");
})
router.post('/login', logeo);
router.post('/addUser', addUser);
router.get('/infoUser/:id', infoUser);
router.get('/publicaciones', publicaciones);
router.get('/mispublicaciones/:id', misPublicaciones);
router.post('/addpubliacion', addPublicacion);
router.post('/editpublicacion/:id', editPublicacion);
router.delete('/borrarpublicacion/:id', borrarPublicacion);


module.exports = router;