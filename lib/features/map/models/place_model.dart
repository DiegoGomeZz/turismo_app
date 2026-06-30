// features/map/models/place_model.dart
class PlaceModel {
  final String id;
  final String title;
  final String description;
  final String address;
  final String imageUrl;
  final double price;
  final double latitude;
  final double longitude;
  final String category; // Para tus chips de filtros locales

  PlaceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  // Mapear de JSON (Backend) a Modelo (Flutter)
  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id']?.toString() ?? '',
      title: json['titulo'] ?? '',
      description: json['descripcion'] ?? '',
      address: json['direccion'] ?? '',
      imageUrl: json['imagen_url'] ?? '',
      price: (json['precio'] as num?)?.toDouble() ?? 0.0,
      // Si la API no devuelve coordenadas reales, las simulamos en Salta por defecto
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : -24.7859,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : -65.4116,
      category: json['category'] ?? 'Histórico', // Valor por defecto para filtros
    );
  }

  // Mapear de Modelo (Flutter) a JSON para enviar al Backend
  Map<String, dynamic> toJson() {
    return {
      'titulo': title,
      'descripcion': description,
      'direccion': address,
      'imagen_url': imageUrl,
      'precio': price,
      // Enviamos también las coordenadas si el backend las soporta
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
    };
  }
}