class CategoryModel {
  final int id; 
  final String nombre;
  final String imagen;

  const CategoryModel({
    required this.id, 
    required this.nombre, 
    required this.imagen
  });

  // Factory constructor para crear el objeto a partir de un JSON/Map (desde la API/BD)
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt() ?? 0,
      nombre: map['nombre'] ?? 'Sin nombre',
      imagen: map['imagen'] ?? '',
    );
  }

  // Método para convertir el objeto a un Map (para enviar datos al servidor)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'imagen': imagen,
    };
  }
}