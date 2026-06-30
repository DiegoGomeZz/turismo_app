import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/home/models/attraction_model.dart';

//Clase auxiliar para devolver dos cosas al mismo tiempo (Lista + Token)
class PlacesResponse {
  final List<AttractionModel> lugares;
  final String? nextPageToken;

  PlacesResponse({required this.lugares, this.nextPageToken});
}

class GooglePlacesService {
  final String _apiKey = 'AIzaSyBE7vxKzqFmqEBWB0DAsAx73B4O26QdOeI'; 
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place/textsearch/json';

  Future<PlacesResponse> obtenerDestinos(String query, {String? pageToken}) async {

    String urlStr = '$_baseUrl?key=$_apiKey&language=es';
    if (pageToken != null && pageToken.isNotEmpty) {
      urlStr += '&pagetoken=$pageToken';
    } else {
      urlStr += '&query=$query';
    }

    final url = Uri.parse(urlStr);
    
    try {
      final response = await http.get(url);
  
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'INVALID_REQUEST' && pageToken != null) {
          await Future.delayed(const Duration(seconds: 2));
          return obtenerDestinos(query, pageToken: pageToken);
        }

        final List results = data['results'] ?? [];
        final String? nextToken = data['next_page_token'];
        
        final lugares = results.map((json) => AttractionModel.fromGoogleJson(json as Map<String, dynamic>)).toList();
        return PlacesResponse(lugares: lugares, nextPageToken: nextToken);
      } else {
        throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en GooglePlacesService: $e');
      return PlacesResponse(lugares: []); // Devolvemos vacío en caso de error de red
    }
  }
}