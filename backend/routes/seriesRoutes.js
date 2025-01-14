const express = require('express');
const { getSeasonsAndEpisodes } = require('../controllers/seriesController');
const router = express.Router();

// Ruta para obtener temporadas y episodios de una serie
router.get('/series/:seriesId', getSeasonsAndEpisodes);

module.exports = router;
