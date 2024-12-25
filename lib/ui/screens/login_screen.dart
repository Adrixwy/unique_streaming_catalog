import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showRegisterFields = false;

  // Controladores de texto
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  /// Registro
  void handleRegister() {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String repeatPassword = repeatPasswordController.text.trim();

    String result = AuthService.register(username, email, password, repeatPassword);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    if (result == 'Usuario registrado correctamente') {
      setState(() {
        showRegisterFields = false; // Volver al modo de inicio de sesion
        usernameController.clear();
        passwordController.clear();
        emailController.clear();
        repeatPasswordController.clear();
      });
    }
  }

  ///  Inicio de Sesion
  void handleLogin() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (AuthService.login(username, password)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

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
              'assets/images/intro_image.png',
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
                controller: usernameController,
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
              // Correo Electronico
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  controller: emailController,
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
                controller: passwordController,
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
              // Repetir Contraseña
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  controller: repeatPasswordController,
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
                  // Navegar a la pantalla de recuperacion
                },
                child: Text(
                  '¿Has olvidado tu contraseña?',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            SizedBox(height: 10),

            // Boton de accion principal
            ElevatedButton(
              onPressed: showRegisterFields ? handleRegister : handleLogin,
              child: Text(showRegisterFields ? 'Registrarme' : 'Iniciar Sesión'),
            ),

            SizedBox(height: 10),

            // Alternar entre modos
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


