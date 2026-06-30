import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place_model.dart';
import '../services/map_api_service.dart';

class MapProvider extends ChangeNotifier {
  final MapApiService _apiService = MapApiService();

  List<PlaceModel> _places = [];
  String _searchQuery = "";
  bool _isLoading = false;

  final List<String> _categories = ['Todos', 'Restaurantes', 'Compras', 'Hoteles', 'Histórico'];
  String _selectedCategory = 'Todos';

  MapProvider() {
    loadPlacesFromApi();
  }

  List<PlaceModel> get places => _places;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  Future<void> loadPlacesFromApi() async {
    _isLoading = true;
    notifyListeners();

    try {
      _places = await _apiService.fetchPlaces();
    } catch (e) {
      print("Error al cargar atracciones de la API: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlace(PlaceModel newPlace) async {
    _isLoading = true;
    notifyListeners();

    final exito = await _apiService.createPlace(newPlace);
    if (exito) {
      await loadPlacesFromApi();
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removePlace(String placeId) async {
    _isLoading = true;
    notifyListeners();

    final exito = await _apiService.deletePlaceFromServer(placeId);
    if (exito) {
      _places.removeWhere((place) => place.id == placeId);
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<PlaceModel> get filteredPlaces {
    return _places.where((place) {
      final matchesSearch = place.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          place.address.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Todos' || place.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Set<Marker> get markers {
    return filteredPlaces.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(title: place.title, snippet: place.description),
      );
    }).toSet();
  }
}
