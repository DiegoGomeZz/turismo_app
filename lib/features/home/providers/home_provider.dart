import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/category_model.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/core/services/google_places_service.dart';
import 'package:turismo_app/core/services/mock_database_service.dart';

class HomeProvider extends ChangeNotifier {
  final GooglePlacesService _placesService = GooglePlacesService();
  final MockDatabaseService _dbService = MockDatabaseService();

  final List<CategoryModel> _categorias = const [
    CategoryModel(id: 1, nombre: 'Gastronomía', imagen: 'assets/images/gastronomia.webp'),
    CategoryModel(id: 2, nombre: 'Cerros', imagen: 'assets/images/cerros.webp'),
    CategoryModel(id: 3, nombre: 'Museos', imagen: 'assets/images/museos.webp'),
    CategoryModel(id: 4, nombre: 'Escalada', imagen: 'assets/images/escalada.webp'),
  ];

  List<AttractionModel> _destinosPopulares = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<CategoryModel> get categorias => _categorias;
  List<AttractionModel> get destinosPopulares => _destinosPopulares;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  HomeProvider() {
    obtenerDestinos('Atracciones turísticas en Salta');
  }

  Future<void> obtenerDestinos(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final responseGoogle = await _placesService.obtenerDestinos(query);
      if (responseGoogle.lugares.isEmpty) {
        _errorMessage = 'No se encontraron destinos para esta búsqueda.';
      } else {
        _destinosPopulares = await _fusionarConDatosSociales(responseGoogle.lugares);
        _destinosPopulares.sort((a, b) => b.promedioEstrellas.compareTo(a.promedioEstrellas));
      }
    } catch (e) {
      _errorMessage = 'Ocurrió un error al cargar los lugares.';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<AttractionModel>> _fusionarConDatosSociales(List<AttractionModel> lugaresBase) async {
    return await Future.wait(
      lugaresBase.map((lugar) async {
        final datosSociales = await _dbService.getSocialDataForPlace(lugar.id);
        return lugar.copyWith(
          imageUrls: datosSociales['imageUrls'] as List<String>,
          promedioEstrellas: datosSociales['promedioEstrellas'] as double,
          cantidadVotos: datosSociales['cantidadVotos'] as int,
          estadisticasVotos: datosSociales['estadisticasVotos'] as RatingStats,
          comentarios: datosSociales['comentarios'] as List<ReviewModel>,
        );
      }),
    );
  }
}
