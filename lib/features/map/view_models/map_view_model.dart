import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_model.dart';

class MapViewModel extends ChangeNotifier {
  // Lista en memoria de los lugares turísticos
  final List<PlaceModel> _places = [];
  String _searchQuery = "";

  List<PlaceModel> get places => _places;

  // Filtrar lugares según la barra de búsqueda
  List<PlaceModel> get filteredPlaces {
    if (_searchQuery.isEmpty) return _places;
    return _places
        .where((place) =>
            place.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            place.address.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // Convertir los lugares a Marcadores de Google Maps
  Set<Marker> get markers {
    return filteredPlaces.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(title: place.title, snippet: place.description),
      );
    }).toSet();
  }

  // Actualizar la búsqueda
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Agregar un nuevo lugar y refrescar la UI
  void addPlace(PlaceModel newPlace) {
    _places.add(newPlace);
    notifyListeners(); // Esto avisa a Provider que redibuje las vistas
  }

  void removePlace(String placeId) {
  _places.removeWhere((place) => place.id == placeId);
  notifyListeners(); // 🔄 Actualiza el mapa automáticamente
}
}