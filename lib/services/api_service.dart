import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:4000/api';

  /// Iniciar sesión
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    ).timeout(Duration(seconds: 10)); // Agregando timeout

    print('Response body: ${response.body}'); // Depuracion

    final result = _handleResponse(response);

    // Validar si la respuesta incluye el user_id
    if (result.containsKey('user_id')) {
      return result; // Retorna user_id al AuthService
    } else {
      throw Exception('Respuesta inválida del servidor. Falta user_id.');
    }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }


  /// Registrar nuevo usuario
  static Future<Map<String, dynamic>> register(String username, String email, String password) async {
    try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    ).timeout(Duration(seconds: 10)); // Agregando timeout

  return _handleResponse(response);
  } catch (e) {
  throw Exception('Error al conectar con el servidor: $e');
  }
}

  /// Enviar código de restablecimiento de contraseña
  static Future<Map<String, dynamic>> sendResetCode(String email) async {
    try {
      final response = await http.post(
      Uri.parse('$baseUrl/auth/send-reset-code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    ).timeout(Duration(seconds: 10)); // Agregando timeout

    return _handleResponse(response);
  } catch (e) {
  throw Exception('Error al enviar código de restablecimiento: $e');
  }
}

  /// Restablecer contraseña con el código
  static Future<Map<String, dynamic>> resetPassword(String code, String newPassword) async {
    try {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code, 'newPassword': newPassword}),
    ).timeout(Duration(seconds: 10)); // Agregando timeout

    return _handleResponse(response);
  } catch (e) {
  throw Exception('Error al restablecer contraseña: $e');
  }
}

  /// Metodo estático para validar el formato del correo electrónico
  static bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  /// Manejar respuestas
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception('Error al decodificar la respuesta del servidor: $e');
      }
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        throw Exception('Error: ${errorBody['message'] ?? 'Error desconocido'}');
      } catch (e) {
        throw Exception(
            'Error en la solicitud: Código ${response.statusCode}, Cuerpo: ${response.body}');
      }
    }
  }

  /// Obtener el catálogo de contenidos
  static Future<List<Map<String, dynamic>>> fetchContents() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/content/contents'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10)); // Agregando timeout

      if (response.statusCode == 200) {
        // Decodificar y retornar la lista de contenidos
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.cast<Map<String, dynamic>>(); // Convertir a una lista de mapas
      } else {
        throw Exception('Error al obtener el catálogo: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }

}



