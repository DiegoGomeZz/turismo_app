class EventModel {
  final String id;
  final String titulo;
  final String descripcion;
  final DateTime fechaEvento;
  final String direccion;
  final double precio;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaEvento,
    required this.direccion,
    required this.precio,
    required this.imageUrl,
  });
}