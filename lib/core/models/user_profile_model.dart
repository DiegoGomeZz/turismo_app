
class Profile{
  final String nombre;
  final String nombreUsuario;
  final String email;
  final String imagen;
  final DateTime fechaCreacion;
  final String descripcion;
  final int seguidores;
  final int seguidos;


  Profile({
    required this.nombre,
    required this.nombreUsuario,
    required this.email,
    required this.imagen,
    required this.fechaCreacion,
    required this.descripcion,
    required this.seguidores,
    required this.seguidos,
  });
}