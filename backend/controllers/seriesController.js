// Obtener temporadas y episodios de una serie específica
const getSeasonsAndEpisodes = async (req, res) => {
  const { seriesId } = req.params;

  try {
    // Obtener las temporadas
    const seasons = await pool.query(
      'SELECT * FROM temporadas WHERE contenido_id = $1 ORDER BY numero_temporada ASC',
      [seriesId]
    );

    // Obtener los episodios
    const episodes = await pool.query(
      'SELECT * FROM episodios WHERE contenido_id = $1 ORDER BY numero_temporada ASC, numero_episodio ASC',
      [seriesId]
    );

    res.status(200).json({
      seasons: seasons.rows,
      episodes: episodes.rows,
    });
  } catch (error) {
    console.error('Error al obtener temporadas y episodios:', error);
    res.status(500).json({ message: 'Error al obtener temporadas y episodios' });
  }
};

module.exports = { getSeasonsAndEpisodes };
