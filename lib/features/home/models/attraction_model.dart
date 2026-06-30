class AttractionModel {
  // CAPA GOOGLE
  final String id; // place_id
  final String titulo; // name
  final String direccion; // formatted_address
  final String fotoReferenciaGoogle; // Referencia cruda para armar la URL si no hay fotos de usuarios

  // CAPA Datos de app o postgreSQL
  final List<String> imageUrls; // Fotos subidas por tus usuarios
  final double promedioEstrellas;
  final int cantidadVotos;
  final RatingStats estadisticasVotos;
  final List<ReviewModel> comentarios;

  AttractionModel({
    required this.id,
    required this.titulo,
    required this.direccion,
    required this.fotoReferenciaGoogle,
    required this.imageUrls,
    required this.promedioEstrellas,
    required this.cantidadVotos,
    required this.estadisticasVotos,
    required this.comentarios,
  });

  // CONSTRUCTOR DESDE GOOGLE, Nace con los datos reales de la API, pero los datos sociales inician vacíos.
  factory AttractionModel.fromGoogleJson(Map<String, dynamic> json) {
    String referencia = '';
    if (json['photos'] != null && (json['photos'] as List).isNotEmpty) {
      referencia = json['photos'][0]['photo_reference'];
    }

    return AttractionModel(
      id: json['place_id'] ?? '',
      titulo: json['name'] ?? 'Destino sin nombre',
      direccion: json['formatted_address'] ?? 'Sin dirección registrada',
      fotoReferenciaGoogle: referencia,
      
      // Inicialización social en cero
      imageUrls: const [],
      promedioEstrellas: 0.0,
      cantidadVotos: 0,
      estadisticasVotos: RatingStats.empty(),
      comentarios: const [],
    );
  }

  AttractionModel copyWith({ // Permite al Controlador tomar el destino de Google e inyectarle los datos de la BD.
    List<String>? imageUrls,
    double? promedioEstrellas,
    int? cantidadVotos,
    RatingStats? estadisticasVotos,
    List<ReviewModel>? comentarios,
  }) {
    return AttractionModel(
      id: id,
      titulo: titulo,
      direccion: direccion,
      fotoReferenciaGoogle: fotoReferenciaGoogle,
      imageUrls: imageUrls ?? this.imageUrls,
      promedioEstrellas: promedioEstrellas ?? this.promedioEstrellas,
      cantidadVotos: cantidadVotos ?? this.cantidadVotos,
      estadisticasVotos: estadisticasVotos ?? this.estadisticasVotos,
      comentarios: comentarios ?? this.comentarios,
    );
  }

  // --- HELPERS Y GETTERS DE IMÁGENES ---

  // Helper privado para construir la URL de Google si existe
  String get _googleImageUrl {
    if (fotoReferenciaGoogle.isNotEmpty) {
      const apiKey = 'AIzaSyBE7vxKzqFmqEBWB0DAsAx73B4O26QdOeI'; 
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=$fotoReferenciaGoogle&key=$apiKey';
    }
    return '';
  }

  // 1. Imagen de Portada (Para las tarjetas pequeñas en el Home)
  String get coverImage {
    final urlGoogle = _googleImageUrl;
    // Prioridad 1: Siempre la de Google
    if (urlGoogle.isNotEmpty) return urlGoogle;
    
    // Prioridad 2: Si Google no tiene foto, usamos la primera de los usuarios
    if (imageUrls.isNotEmpty) return imageUrls.first;
    
    // Prioridad 3: Imagen por defecto si no hay absolutamente nada
    return 'https://via.placeholder.com/400x300?text=Sin+Imagen';
  }

  // 2. Lista Combinada (Para el carrusel de la pantalla de detalles)
  List<String> get todasLasImagenes {
    final List<String> combinadas = [];
    
    final urlGoogle = _googleImageUrl;
    if (urlGoogle.isNotEmpty) {
      combinadas.add(urlGoogle); // Posición 0: Siempre Google
    }
    
    combinadas.addAll(imageUrls); // Agregamos las fotos de los usuarios a continuación
    
    // Protección visual por si la lista quedó completamente vacía
    if (combinadas.isEmpty) {
      combinadas.add('https://via.placeholder.com/400x300?text=Sin+Imagen');
    }
    
    return combinadas;
  }
}


class RatingStats {
  final int estrellas5;
  final int estrellas4;
  final int estrellas3;
  final int estrellas2;
  final int estrellas1;

  RatingStats({
    required this.estrellas5,
    required this.estrellas4,
    required this.estrellas3,
    required this.estrellas2,
    required this.estrellas1,
  });

  factory RatingStats.empty() {
    return RatingStats(
      estrellas5: 0,
      estrellas4: 0,
      estrellas3: 0,
      estrellas2: 0,
      estrellas1: 0,
    );
  }
}

class ReviewModel {
  final String id;
  final String nombreUsuario;
  final String avatarUrl;
  final double puntuacion;
  final String comentario;
  final DateTime fecha;

  ReviewModel({
    required this.id,
    required this.nombreUsuario,
    required this.avatarUrl,
    required this.puntuacion,
    required this.comentario,
    required this.fecha,
  });
}