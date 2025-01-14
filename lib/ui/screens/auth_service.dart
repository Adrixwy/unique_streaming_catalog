

  import '../../services/api_service.dart';

  class AuthService {
    static String? loggedInUser; // Almacena el usuario que ha iniciado sesion
    static int? loggedInUserId; // ID del usuario que ha iniciado sesion

    /// Iniciar sesión
    static Future<String> login(String username, String password) async {
      try {
        final response = await ApiService.login(username, password);
        print('Respuesta de la API: $response'); // <-- Depuración

        if (response['user_id'] != null) {
          loggedInUser = username;
          loggedInUserId = response['user_id'];
          print('User ID: $loggedInUserId');
          return 'Inicio de sesión exitoso';
        } else {
          return response['message'] ?? 'Error desconocido';
        }
      } catch (e) {
        return 'Error al iniciar sesión: $e';
      }
    }

    /// Registrar nuevo usuario
    static Future<String> register(String username, String email, String password) async {
      try {
        final response = await ApiService.register(username, email, password);

        if (response['success'] == true) {
          return 'Registro exitoso: ${response['message']}';
        } else {
          return response['message'] ?? 'Error en el registro';
        }
      } catch (e) {
        return 'Error al registrar usuario: $e';
      }
    }

    /// Restablecer contraseña
    static Future<String> resetPassword(String email, String newPassword) async {
      try {
        final response = await ApiService.resetPassword(email, newPassword);

        if (response['success'] == true) {
          return 'Contraseña restablecida correctamente';
        } else {
          return response['message'] ?? 'Error al restablecer contraseña';
        }
      } catch (e) {
        return 'Error al restablecer contraseña: $e';
      }
    }

    /// Cerrar sesión
    static void logout() {
      loggedInUser = null;
      loggedInUserId = null; // Limpia el ID del usuario al cerrar sesion
      print('Sesión cerrada');
    }
  }
