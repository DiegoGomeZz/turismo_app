class AtractionEventModel {
  String titulo;
  String descripcion;
  String imageUrl;
  int estrellas; // segun votos de la gente, del 1 al 5
  int cantidadVotos;
  DateTime fechaEvento;

  AtractionEventModel({
    required this.titulo,
    required this.descripcion,
    required this.imageUrl,
    required this.estrellas,
    required this.cantidadVotos,
    required this.fechaEvento,
  });


}