const pool = require('../db'); // Conexion a la base de datos

// Agregar un favorito
const addFavorite = async (req, res) => {
  const { userId, contentId } = req.body;

  if (!userId || !contentId) {
    return res.status(400).json({ message: 'userId y contentId son requeridos' });
  }

  try {
    // Comprobar si ya está marcado como favorito
    const exists = await pool.query(
      'SELECT * FROM favoritos WHERE id_usuario  = $1 AND id_contenido = $2',
      [userId, contentId]
    );

    if (exists.rows.length > 0) {
      return res.status(400).json({ message: 'El contenido ya está marcado como favorito' });
    }

    // Insertar nuevo favorito
    await pool.query(
      'INSERT INTO favoritos (id_usuario, id_contenido) VALUES ($1, $2)',
      [userId, contentId]
    );

    res.status(201).json({ message: 'Favorito agregado exitosamente' });
  } catch (error) {
    console.error('Error al agregar favorito:', error);
    res.status(500).json({ message: 'Error al agregar favorito' });
  }
};

// Eliminar un favorito
const removeFavorite = async (req, res) => {
  const { userId, contentId } = req.body;

  if (!userId || !contentId) {
    return res.status(400).json({ message: 'userId y contentId son requeridos' });
  }

  try {
    // Eliminar favorito
    const result = await pool.query(
      'DELETE FROM favoritos WHERE id_usuario = $1 AND id_contenido = $2',
      [userId, contentId]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Favorito no encontrado' });
    }

    res.status(200).json({ message: 'Favorito eliminado exitosamente' });
  } catch (error) {
    console.error('Error al eliminar favorito:', error);
    res.status(500).json({ message: 'Error al eliminar favorito' });
  }
};

// Obtener todos los favoritos de un usuario
const getFavorites = async (req, res) => {
  const userId = req.params.userId;

  if (!userId) {
    return res.status(400).json({ message: 'userId es requerido' });
  }

  try {
    // Obtener favoritos del usuario
    const favorites = await pool.query(
      'SELECT c.* FROM favoritos f JOIN contenido c ON f.id_contenido = c.id WHERE f.id_usuario = $1',
      [userId]
    );

    res.status(200).json({ userId, favorites: favorites.rows });
  } catch (error) {
    console.error('Error al obtener favoritos:', error);
    res.status(500).json({ message: 'Error al obtener favoritos' });
  }
};

module.exports = {
  addFavorite,
  removeFavorite,
  getFavorites,
};


