import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'forgot_password_screen.dart';
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
  void handleRegister() async  {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String repeatPassword = repeatPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    String result = await AuthService.register(username, email, password);

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  /// Inicio de Sesion
  void handleLogin() async  {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    // Esperar la respuesta del login
    String result = await AuthService.login(username, password);

    if (result == 'Inicio de sesión exitoso') {
      // Si el login es exitoso, navegar a la pantalla de inicio
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Si hay un error, mostrar el mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400), // Máximo ancho
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),

                // Nombre App (ajustes y proporciones)
                Image.asset(
                  'assets/imagenes/Solo Nombre.jpg',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),

                // Logo  App
                Image.asset(
                  'assets/imagenes/Solo Logo1.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 30),

                // Campo Usuario
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Usuario',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                if (showRegisterFields) ...[
                  SizedBox(height: 10),
                  // Correo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo Electrónico',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[850],
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],

                SizedBox(height: 10),
                // Contraseña
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                if (showRegisterFields) ...[
                  SizedBox(height: 10),
                  // Repetir Contraseña
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: repeatPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Repetir Contraseña',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[850],
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],

                SizedBox(height: 15),

                // Boton Resetear Contraseña
                if (!showRegisterFields)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      '¿Has olvidado tu contraseña?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),

                SizedBox(height: 10),

                // Boton Logueo y registro
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: showRegisterFields ? handleRegister : handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(showRegisterFields ? 'Registrarme' : 'Iniciar Sesión'),
                  ),
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
        ),
      ),
    );
  }
}
