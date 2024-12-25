import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showRegisterFields = false; // Controlar si se muestran campos de registro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            // Imagen cabecera ancho pantalla
            Image.asset(
              'assets/images/intro_image.png', // insertar imagen y ruta
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // Logo app
            Icon(Icons.movie, color: Colors.white, size: 100),
            SizedBox(height: 20),
            // Usuario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (showRegisterFields) ...[
              SizedBox(height: 10),
              // Correo Electrónico (debajo de Usuario)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Correo Electrónico',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            SizedBox(height: 10),
            // Contraseña
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (showRegisterFields) ...[
              SizedBox(height: 10),
              // Repetir Contraseña (debajo de Contraseña)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Repetir Contraseña',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            SizedBox(height: 10),
            // Reseteo contraseña
            if (!showRegisterFields)
              TextButton(
                onPressed: () {
                  // Navegar a la pantalla de recuperación
                },
                child: Text(
                  '¿Has olvidado tu contraseña?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            SizedBox(height: 10),
            // Botón Iniciar Sesión
            ElevatedButton(
              onPressed: () {
                // Lógica de inicio de sesión
              },
              child: Text(showRegisterFields ? 'Registrarme' : 'Iniciar Sesión'),
            ),
            SizedBox(height: 10),
            // Botón para alternar entre modos
            TextButton(
              onPressed: () {
                setState(() {
                  showRegisterFields = !showRegisterFields;
                });
              },
              child: Text(
                showRegisterFields
                    ? '¿Ya tienes una cuenta? Inicia sesión'
                    : '¿No tienes una cuenta? Regístrate',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

