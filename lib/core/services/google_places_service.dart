import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/home/models/attraction_model.dart';

class GooglePlacesService {
  // Reemplaza esto con la misma API Key de tu Manifest
  final String _apiKey = 'AIzaSyBE7vxKzqFmqEBWB0DAsAx73B4O26QdOeI'; 
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place/textsearch/json';

  //Future porque es una operación asíncrona
  Future<List<AttractionModel>> obtenerDestinos(String query) async {
    // Armamos la URL con la búsqueda, tu llave y pidiendo los resultados en español
    final url = Uri.parse('$_baseUrl?query=$query&key=$_apiKey&language=es');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        // Si Google responde OK, decodificamos el JSON
        final data = json.decode(response.body);
        final List results = data['results'];
        
        // Transformamos la lista de JSON crudo en una lista de nuestros objetos AttractionModel
        return results.map((json) => AttractionModel.fromJson(json)).toList();
      } else {
        throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en GooglePlacesService: $e');
      return []; // Si hay un error (ej. no hay internet), devolvemos una lista vacía
    }
  }
}