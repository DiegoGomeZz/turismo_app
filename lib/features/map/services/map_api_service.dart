// features/map/services/map_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place_model.dart';

class MapApiService {
  // La URL Base oficial provista por tu compañero de equipo
  static const String _baseUrl = 'https://p01--turismo-app-back--rzjxhlb42yvn.code.run';

  // 1. GET /attractions/ -> Obtener todas las atracciones
  Future<List<PlaceModel>> fetchPlaces() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/attractions/'));

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => PlaceModel.fromJson(item)).toList();
      } else {
        throw Exception('Error en el servidor al obtener las atracciones.');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  // 2. POST /attractions/create/ -> Crear un nuevo evento/atracción
  Future<bool> createPlace(PlaceModel place) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/attractions/create/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(place.toJson()),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // 3. DELETE /attractions/{id}/delete/ -> Eliminar evento (Lógica de tu compañero)
  Future<bool> deletePlaceFromServer(String placeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/attractions/$placeId/delete/'),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}