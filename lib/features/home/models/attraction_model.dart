class AttractionModel {
  final String id;
  final String titulo;
  final String descripcion;
  final List<String> imageUrls; 
  final double promedioEstrellas; 
  final int cantidadVotos;
  final DateTime? fechaEvento; // Opcional, no todos son eventos
  final String direccion;
  final RatingStats estadisticasVotos;
  final List<ReviewModel> comentarios;
  final double? precio; // Opcional, no todas las atracciones tienen precio

  AttractionModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imageUrls,
    required this.promedioEstrellas,
    required this.cantidadVotos,
    this.fechaEvento,
    required this.direccion,
    required this.estadisticasVotos,
    required this.comentarios,
    this.precio = 0.0,
  });

  // Getter para retrocompatibilidad con card actual
  String get coverImage => imageUrls.isNotEmpty ? imageUrls.first : '';
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