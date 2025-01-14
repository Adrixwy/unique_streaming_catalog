const express = require('express');
const router = express.Router();
const pool = require('../db'); // Asegúrate de importar correctamente tu pool de base de datos

// Obtener favoritos por usuario
router.get('/:userId', async (req, res) => {
    const userId = req.params.userId;
    try {
        const result = await pool.query(
            'SELECT * FROM favoritos WHERE id_usuario = $1',
            [userId]
        );
        res.json(result.rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al obtener los favoritos.' });
    }
});

// Guardar un contenido como favorito
router.post('/', async (req, res) => {
    const { id_usuario, id_contenido } = req.body;
    const fecha = new Date();
    try {
        const result = await pool.query(
            'INSERT INTO favoritos (id_usuario, id_contenido, favorito_guardado) VALUES ($1, $2, $3) RETURNING *',
            [id_usuario, id_contenido, fecha]
        );
        res.json(result.rows[0]);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error al guardar el favorito.' });
    }
});

module.exports = router;
