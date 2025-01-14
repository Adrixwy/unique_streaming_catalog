const express = require('express');
const {
    addFavorite,
    removeFavorite,
    getFavorites,
} = require('../controllers/favoritesController');

const { getContents } = require('../controllers/contentController');


const router = express.Router();

// Rutas para favoritos
router.post('/favorites/add', addFavorite);
router.post('/favorites/remove', removeFavorite);
router.get('/favorites/:userId', getFavorites);
router.get('/contents', getContents);

module.exports = router;

