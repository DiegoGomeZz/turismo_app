import 'dart:math';
import 'package:turismo_app/features/home/models/attraction_model.dart';

class MockDatabaseService {
  
  /// Simula pedirle a tu base de datos (PostgreSQL) los datos sociales de un lugar específico.
  Future<Map<String, dynamic>> getSocialDataForPlace(String placeId) async {
    // 1. Simulamos la latencia de la red (lo que tardaría tu servidor en responder)
    await Future.delayed(const Duration(milliseconds: 600));

    // 2. Usamos el placeId como "semilla" matemática. 
    // Esto asegura que el lugar "A" siempre genere el mismo mock, y el "B" otro distinto.
    final random = Random(placeId.hashCode);
    
    // Simulamos que solo el 70% de los lugares de Google tienen reseñas en tu app.
    final hasDataInOurApp = random.nextDouble() > 0.3; 

    if (!hasDataInOurApp) {
      // Si nadie ha publicado nada en tu app, devolvemos los datos en cero.
      return {
        'imageUrls': <String>[],
        'promedioEstrellas': 0.0,
        'cantidadVotos': 0,
        'estadisticasVotos': RatingStats.empty(),
        'comentarios': <ReviewModel>[],
      };
    }

    // 3. Generación de datos ficticios (Mock) para los lugares que sí tienen interacción
    final cantidadVotos = random.nextInt(150) + 5; // Entre 5 y 155 votos
    final double promedio = (random.nextDouble() * 2 + 3); // Promedio entre 3.0 y 5.0

    // Fotos subidas por los usuarios de tu app (usamos Unsplash para fotos de prueba hermosas)
    final imagenes = [
      'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800&q=80',
      'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80',
    ];

    // Calculamos las barras de estrellas simulando una distribución realista
    final stats = RatingStats(
      estrellas5: (cantidadVotos * 0.5).round(),
      estrellas4: (cantidadVotos * 0.3).round(),
      estrellas3: (cantidadVotos * 0.1).round(),
      estrellas2: (cantidadVotos * 0.05).round(),
      estrellas1: (cantidadVotos * 0.05).round(),
    );

    // Creamos un par de comentarios falsos
    final comentarios = [
      ReviewModel(
        id: 'rev_${placeId}_1',
        nombreUsuario: 'Yamil Homero',
        avatarUrl: 'https://randomuser.me/api/portraits/men/${random.nextInt(50)}.jpg',
        puntuacion: 5.0,
        comentario: '¡Un lugar increíble! De lo mejor que tiene Salta. Volvería mil veces.',
        fecha: DateTime.now().subtract(Duration(days: random.nextInt(10))),
      ),
      ReviewModel(
        id: 'rev_${placeId}_2',
        nombreUsuario: 'Cami Cisnero',
        avatarUrl: 'https://randomuser.me/api/portraits/women/${random.nextInt(50)}.jpg',
        puntuacion: 4.0,
        comentario: 'Muy lindo todo, pero sugiero ir temprano para evitar la multitud.',
        fecha: DateTime.now().subtract(Duration(days: random.nextInt(30) + 10)),
      ),
    ];

    // Devolvemos el diccionario estructurado tal cual lo haría una API REST real.
    return {
      'imageUrls': imagenes,
      'promedioEstrellas': double.parse(promedio.toStringAsFixed(1)),
      'cantidadVotos': cantidadVotos,
      'estadisticasVotos': stats,
      'comentarios': comentarios,
    };
  }
}