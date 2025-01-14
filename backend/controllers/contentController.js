const db = require('../db'); // conexion a la base de datos

// Obtener todos los contenidos
const getContents = async (req, res) => {
    try {
        const query = `
            SELECT c.id, c.titulo, c.descripcion, c.año_estreno, c.imagen,
                   tc.nombre AS tipo, p.nombre AS plataforma
            FROM contenido c
            JOIN tipo_contenido tc ON c.tipo_contenido_id = tc.id
            JOIN plataformas p ON c.plataforma_id = p.id;
        `;
        const { rows } = await db.query(query);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error al obtener contenidos:', error);
        res.status(500).json({ error: 'Error al obtener los contenidos' });
    }
};

module.exports = { getContents };
