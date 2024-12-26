class AuthService {
  static final List<Map<String, String>> _users = []; // Almacén temporal de usuarios

  /// Validar formato de correo
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  /// Verificar si el usuario ya existe
  static bool userExists(String username) {
    return _users.any((user) => user['username'] == username);
  }

  /// Registrar nuevo usuario
  static String register(String username, String email, String password, String repeatPassword) {
    if (username.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      return 'Todos los campos son obligatorios.';
    }

    if (!isValidEmail(email)) {
      return 'El formato del correo es incorrecto';
    }

    if (userExists(username)) {
      return 'El usuario ya existe';
    }

    if (password != repeatPassword) {
      return 'Las contraseñas no coinciden';
    }

    _users.add({
      'username': username,
      'email': email,
      'password': password,
    });

    return 'Usuario registrado correctamente';
  }

  /// Iniciar sesion
  static String? loggedInUser; // Almacenar nombre usuario que ha iniciado sesion
  static bool login(String username, String password) {
    for (var user in _users) {
      if (user['username'] == username && user['password'] == password) {
        loggedInUser = user['username']; // Guarda el nombre de usuario
        return true;
      }
    }
    return false;
  }

  /// Verificar si el correo existe
  static bool emailExists(String email) {
    return _users.any((user) => user['email'] == email);
  }

  /// Verificar Código de Restablecimiento
  static bool verifyResetCode(String code) {
    return code == '123456'; // Código fijo para la demo
  }

  /// Restablecer Contraseña
  static void resetPassword(String email, String newPassword) {
    for (var user in _users) {
      if (user['email'] == email) {
        user['password'] = newPassword;
        break;
      }
    }
  }

}
