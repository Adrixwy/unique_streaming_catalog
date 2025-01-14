const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../db'); // Conexión a la base de datos

const router = express.Router();
const JWT_SECRET = 'secret_key'; // Cambiar por una clave segura

// Registro de usuario
router.post('/register', async (req, res) => {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
        return res.status(400).json({ message: 'Por favor, completa todos los campos' });
    }

    try {
        const userExists = await pool.query('SELECT * FROM usuarios WHERE email = $1', [email]);

        if (userExists.rows.length > 0) {
            return res.status(400).json({ message: 'El usuario ya existe con este correo electrónico' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        // Asegurarse de que la inserción en la base de datos es exitosa
        const result = await pool.query(
            'INSERT INTO usuarios (nombre_usuario, email, contraseña) VALUES ($1, $2, $3) RETURNING *',
            [username, email, hashedPassword]
        );

        // Verifica si se ha insertado correctamente el usuario
        if (result.rows.length === 0) {
            return res.status(500).json({ success: false, message: 'Error al registrar usuario' });
        }

        res.status(201).json({ success: true, message: 'Usuario registrado correctamente' });
    } catch (error) {
        console.error('Error al registrar el usuario:', error);
        res.status(500).json({ success: false, message: 'Error al registrar usuario' });
    }
});

// Inicio de sesion
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Por favor, completa todos los campos' });
  }

  try {
    const user = await pool.query('SELECT * FROM usuarios WHERE nombre_usuario = $1', [username]);

    if (user.rows.length === 0) {
      return res.status(400).json({ message: 'Usuario no encontrado' });
    }

    const isValidPassword = await bcrypt.compare(password, user.rows[0].contraseña);

    if (!isValidPassword) {
      return res.status(400).json({ message: 'Credenciales incorrectas' });
    }

    // Enviar  el user_id
    res.json({user_id: user.rows[0].id, message: 'Inicio de sesión exitoso' });
  } catch (error) {
    console.error('Error al iniciar sesión:', error);
    res.status(500).json({ success: false, message: 'Error al iniciar sesión' });
  }
});

module.exports = router;
