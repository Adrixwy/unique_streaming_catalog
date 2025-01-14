import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  bool codeSent = false; // Estado para alternar entre las dos vistas

  /// Enviar Código al Correo
  void sendCode() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa tu correo electrónico')),
      );
      return;
    }

    if (!ApiService.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El formato del correo es incorrecto')),
      );
      return;
    }

    try {
      // Enviar la solicitud al backend para enviar el código
      var response = await ApiService.sendResetCode(email);
      setState(() {
        codeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se ha enviado un código a tu correo electrónico')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El correo electrónico no está registrado o hubo un error')),
      );
    }
  }

  /// Resetear Contraseña
  void resetPassword() async {
    String code = codeController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String repeatPassword = repeatPasswordController.text.trim();

    if (code.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return;
    }

    if (newPassword != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    try {
      // Restablecer la contraseña usando el código
      var response = await ApiService.resetPassword(code, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contraseña reseteada correctamente')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El código es incorrecto o hubo un error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Vista para ingresar el correo
              if (!codeSent)
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: sendCode,
                      child: Text('Enviar código'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  ],
                )
              else
              // Vista para ingresar el código y la nueva contraseña
                Column(
                  children: [
                    TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        labelText: 'Código de verificación',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Nueva contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: repeatPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Repetir contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resetPassword,
                      child: Text('Restablecer contraseña'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
