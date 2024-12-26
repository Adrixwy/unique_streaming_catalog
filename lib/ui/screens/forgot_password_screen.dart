import 'package:flutter/material.dart';
import 'auth_service.dart';
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
  void sendCode() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa tu correo electrónico')),
      );
      return;
    }

    if (!AuthService.isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El formato del correo es incorrecto')),
      );
      return;
    }

    bool emailExists = AuthService.emailExists(email);

    if (emailExists) {
      setState(() {
        codeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se ha enviado un código a tu correo electrónico')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El correo electrónico no está registrado')),
      );
    }
  }

  /// Resetear Contraseña
  void resetPassword() {
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

    if (AuthService.verifyResetCode(code)) {
      AuthService.resetPassword(emailController.text, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contraseña reseteada correctamente')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El código es incorrecto')),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                codeSent ? 'Restablecer Contraseña' : 'Ingresa tu Correo',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),

              // Correo Electrónico (Primer Paso)
              if (!codeSent)
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Correo Electrónico',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),

              if (!codeSent)
                SizedBox(height: 20),

              if (!codeSent)
                ElevatedButton(
                  onPressed: sendCode,
                  child: Text('Enviar Código'),
                ),

              // Código y Nueva Contraseña (Segundo Paso)
              if (codeSent) ...[
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    hintText: 'Código de 6 dígitos',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Nueva Contraseña',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: repeatPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Repetir Nueva Contraseña',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: resetPassword,
                  child: Text('Resetear Contraseña'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
