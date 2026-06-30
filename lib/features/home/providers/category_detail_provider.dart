import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/core/services/google_places_service.dart';
import 'package:turismo_app/core/services/mock_database_service.dart';

class CategoryDetailProvider extends ChangeNotifier {
  final GooglePlacesService _placesService = GooglePlacesService();
  final MockDatabaseService _dbService = MockDatabaseService();

  List<AttractionModel> _attractions = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _errorMessage = '';

  String? _nextPageToken;
  String _currentCategory = '';

  List<AttractionModel> get attractions => _attractions;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String get errorMessage => _errorMessage;
  bool get hasMoreData => _nextPageToken != null;

  Future<void> fetchAttractionsByCategory(String categoryName) async {
    _isLoading = true;
    _errorMessage = '';
    _currentCategory = categoryName;
    _nextPageToken = null;
    notifyListeners();

    try {
      final responseGoogle = await _placesService.obtenerDestinos('$_currentCategory en Salta');

      _nextPageToken = responseGoogle.nextPageToken;

      if (responseGoogle.lugares.isEmpty) {
        _errorMessage = 'No se encontraron lugares para esta categoría.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      _attractions = await _fusionarConDatosSociales(responseGoogle.lugares);
      _attractions.sort((a, b) => b.promedioEstrellas.compareTo(a.promedioEstrellas));
    } catch (e) {
      _errorMessage = 'Error al cargar los lugares.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreAttractions() async {
    if (_isLoadingMore || _nextPageToken == null) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final responseGoogle = await _placesService.obtenerDestinos(
        '$_currentCategory en Salta',
        pageToken: _nextPageToken,
      );

      _nextPageToken = responseGoogle.nextPageToken;

      if (responseGoogle.lugares.isNotEmpty) {
        final nuevosLugaresHibridos = await _fusionarConDatosSociales(responseGoogle.lugares);
        _attractions.addAll(nuevosLugaresHibridos);
        _attractions.sort((a, b) => b.promedioEstrellas.compareTo(a.promedioEstrellas));
      }
    } catch (e) {
      print('Error al cargar más lugares: $e');
    } finally {
      _isLoadingMore = false;
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
