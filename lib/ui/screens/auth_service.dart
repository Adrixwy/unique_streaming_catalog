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

  /// Iniciar sesión
  static bool login(String username, String password) {
    return _users.any((user) => user['username'] == username && user['password'] == password);
  }
}
