import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteService {
  final String apiUrl = 'http://localhost:4000/api/favorites';

  Future<List<Map<String, dynamic>>> getFavorites(int userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2/api/favorites/$userId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body); // Decodifica la respuesta JSON
      return List<Map<String, dynamic>>.from(data); // Convierte la lista de items
    } else {
      throw Exception('Error al obtener favoritos');
    }
  }

  Future<void> addFavorite(int userId, int contentId) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_usuario': userId,
        'id_contenido': contentId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al agregar a favoritos');
    }
  }
}
