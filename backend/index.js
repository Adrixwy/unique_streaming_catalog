const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const contentRoutes = require('./routes/contentRoutes');
const favoritesRouter = require('./routes/favorites');
const seriesRoutes = require('./routes/seriesRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Rutas
app.use('/api/auth', authRoutes);
app.use('/api/content', contentRoutes); // Prefijo exclusivo para contenido
app.use('/api/favorites', favoritesRouter); // Prefijo exclusivo para favoritos
app.use('/api/series', seriesRoutes); // Prefijo exclusivo para series

// Puerto
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});
