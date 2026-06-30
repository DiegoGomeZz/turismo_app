import 'package:turismo_app/features/home/models/attraction_model.dart';

class CategoryDetailController {

  // Toma el ID o nombre de la categoría para saber qué buscar.
Future<List<AttractionModel>> getAttractionsByCategory(String categoryId, {int page = 1, int limit = 10}) async {
    try {
      // 1. Obtener atracciones creadas por usuarios (tu base de datos)
      final userAttractions = await _fetchUserCreatedAttractions(categoryId);

      // 2. Obtener atracciones de la API de Google Places
      final googleAttractions = await _fetchGoogleApiAttractions(categoryId);

      // 3. Combinar ambas listas
      final combinedList = [...userAttractions, ...googleAttractions];

      // Opcional: Podrías ordenar la lista aquí (por ejemplo, por mejor rating)
      combinedList.sort((a, b) => b.promedioEstrellas.compareTo(a.promedioEstrellas));

      return combinedList;
      
    } catch (e) {
      // Manejo de errores (puedes registrar el error en un logger)
      throw Exception('Error al obtener atracciones: $e');
    }
  }


  Future<List<AttractionModel>> _fetchUserCreatedAttractions(String categoryId) async {
    // Aquí iría tu lógica real, por ejemplo, una consulta a Firebase Firestore:
    // final snapshot = await FirebaseFirestore.instance.collection('attractions').where('categoryId', isEqualTo: categoryId).get();
    // return snapshot.docs.map((doc) => AttractionModel.fromMap(doc.data())).toList();
    
    return [
      AttractionModel(
        id: '1',
        titulo: 'museo de arqueología de alta montaña',
        descripcion: 'hola hola este es el museo de arqueología de alta montaña, un lugar fascinante que alberga las momias mejor conservadas del mundo. Ubicado en la ciudad de Salta, Argentina, este museo ofrece a los visitantes una experiencia única para conocer la historia y cultura de las civilizaciones precolombinas que habitaron la región andina.',
        promedioEstrellas: 3,
        cantidadVotos: 1200,
        direccion: 'Calle Falsa 123',
        imageUrls: [
          'https://media-cdn.tripadvisor.com/media/photo-s/1b/4a/c2/c0/maam-museo-de-arqueologia.jpg',
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/c7/ce/65/museo-pajcha-arte-etnico.jpg?w=600&h=600&s=1',
          'https://thebigtraveltheory.fr/wp-content/uploads/2018/09/MAAM-1.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 1000, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '1',
            nombreUsuario: 'Yamil Homero',
            avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
            puntuacion: 5.0,
            comentario: '¡Increíble experiencia! Las momias están muy bien conservadas y el museo es muy educativo.',
            fecha: DateTime.now().subtract(const Duration(days: 2)),
          ),
          ReviewModel(
            id: '2',
            nombreUsuario: 'Cami Cisnero',
            avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
            puntuacion: 4.5,
            comentario: 'Muy interesante, aunque me hubiera gustado que hubiera más información en inglés.',
            fecha: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
      AttractionModel(
        id: '2',
        titulo: 'parque nacional los cardones',
        descripcion: 'El Parque Nacional Los Cardones es una reserva natural ubicada en la provincia de Salta, Argentina. Este parque se destaca por su impresionante paisaje desértico, dominado por la presencia de los cardones, que son enormes cactus que pueden alcanzar hasta 10 metros de altura. El parque ofrece a los visitantes la oportunidad de explorar senderos rodeados de estos majestuosos cactus, así como disfrutar de vistas panorámicas de las montañas y el valle circundante. Es un destino ideal para los amantes de la naturaleza y aquellos que buscan una experiencia única en un entorno árido y fascinante.',
        promedioEstrellas: 4.5,
        cantidadVotos: 800,
        direccion: 'Ruta Provincial 33, Salta',
        imageUrls: [
          'https://peakvisor.com/photo/Parque-Nacional-Los-Cardones-Argentina-hiking.jpg',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/parque-nacional-los-cardones.jpg?itok=9n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/parque-nacional-los-cardones-salta.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 600, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '3',
            nombreUsuario: 'Lihuel Rojas',
            avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
            puntuacion: 4.0,
            comentario: 'El paisaje es impresionante, pero ten cuidado con el clima, puede ser muy caluroso en verano.',
            fecha: DateTime.now().subtract(const Duration(days: 3)),
          ),
          ReviewModel(
            id: '4',
            nombreUsuario: 'Sofi Martínez',
            avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
            puntuacion: 5.0,
            comentario: '¡Un lugar mágico! Los cardones son realmente impresionantes y el parque está muy bien cuidado.',
            fecha: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ],
      ),
      AttractionModel(
        id: '3',
        titulo: 'cerro san bernardo',
        descripcion: 'El Cerro San Bernardo es un cerro ubicado en la ciudad de Salta, Argentina. Es un lugar popular para los turistas y locales debido a su fácil acceso y las vistas panorámicas que ofrece de la ciudad y las montañas circundantes. En la cima del cerro, los visitantes pueden disfrutar de un mirador, un pequeño parque y una capilla. Es un destino ideal para aquellos que buscan una caminata corta con una recompensa visual impresionante al final.',
        promedioEstrellas: 4.0,
        cantidadVotos: 500,
        direccion: 'Calle Falsa 456, Salta',
        imageUrls: [
          'https://4.bp.blogspot.com/-G9eE0qOeaO8/VK4XG3li8bI/AAAAAAAABcc/1cLizI0x4Qo/s1600/PICT0082.JPG',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/cerro-san-bernardo.jpg?itok=8n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/cerro-san-bernardo-salta.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 300, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '5',
            nombreUsuario: 'Tomi López',
            avatarUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
            puntuacion: 4.0,
            comentario: 'Un lugar increíble con vistas espectaculares. ¡Muy recomendable!',
            fecha: DateTime.now().subtract(const Duration(days: 4)),
          ),
        ],
      ),
      AttractionModel(
        id: '4',
        titulo: 'salinas grandes',
        descripcion: 'Las Salinas Grandes son un vasto salar ubicado en la provincia de Salta, Argentina. Este impresionante paisaje natural se caracteriza por su extensión blanca y brillante, que se extiende hasta el horizonte. Las Salinas Grandes son un destino popular para los turistas debido a su belleza única y su atmósfera surrealista. Los visitantes pueden caminar sobre la superficie del salar, tomar fotografías impresionantes y disfrutar de las vistas panorámicas de las montañas circundantes. Es un lugar ideal para aquellos que buscan una experiencia única en un entorno natural impresionante.',
        promedioEstrellas: 4.5,
        cantidadVotos: 700,
        direccion: 'Ruta Provincial 52, Salta',
        imageUrls: [
          'https://res.cloudinary.com/worldpackers/image/upload/c_limit,f_auto,q_auto,w_1140/vydhc16tnccanj2ja1r7',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/salinas-grandes.jpg?itok=7n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/salinas-grandes-salta.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 500, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '6',
            nombreUsuario: 'Lihuel Rojas',
            avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
            puntuacion: 4.0,
            comentario: 'Una experiencia inolvidable en uno de los lugares más hermosos de Argentina.',
            fecha: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ],
      ),
      AttractionModel(
        id: '5',
        titulo: 'catedral de salta',
        descripcion: 'La Catedral de Salta, también conocida como la Catedral Basílica de Salta, es una impresionante iglesia ubicada en el centro de la ciudad de Salta, Argentina. Esta catedral es un ejemplo destacado de la arquitectura colonial española y es uno de los principales puntos de referencia de la ciudad. La fachada de la catedral presenta detalles ornamentales y una combinación de estilos arquitectónicos, incluyendo elementos barrocos y neoclásicos. En su interior, los visitantes pueden admirar hermosos altares, vitrales coloridos y obras de arte religioso. La Catedral de Salta es un lugar importante tanto para los fieles como para los turistas que desean conocer la historia y cultura de la región.',
        promedioEstrellas: 4.0,
        cantidadVotos: 600,
        direccion: 'Plaza 9 de Julio, Salta',
        imageUrls: [
          'https://th.bing.com/th/id/R.86e3b1796808c111ba8f393949a3494b?rik=PQAQprkMsGwVBg&pid=ImgRaw&r=0',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/catedral-de-salta.jpg?itok=6n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/catedral-de-salta.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 400, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '7',
            nombreUsuario: 'Sofi Martínez',
            avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
            puntuacion: 4.0,
            comentario: 'Un lugar increíble con una arquitectura impresionante.',
            fecha: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ],
      ),
      AttractionModel(
        id: '6',
        titulo: 'casa de guemes',
        descripcion: 'La Casa de Güemes es un museo histórico ubicado en la ciudad de Salta, Argentina. Este museo está dedicado a la vida y obra de Martín Miguel de Güemes, un héroe nacional argentino que desempeñó un papel crucial en la lucha por la independencia del país. La casa original fue construida en el siglo XVIII y ha sido restaurada para preservar su valor histórico. En su interior, los visitantes pueden encontrar una colección de objetos personales, documentos históricos y exhibiciones que narran la historia de Güemes y su impacto en la región. La Casa de Güemes es un destino importante para aquellos interesados en la historia argentina y la figura de este destacado líder.',
        promedioEstrellas: 4.5,
        cantidadVotos: 500,
        direccion: 'Calle Falsa 789, Salta',
        imageUrls: [
          'https://guemes.salta.gob.ar/public/images/contenidos/museo-casa-de-guemes-actualidad.jpg',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/casa-de-guemes.jpg?itok=5n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/casa-de-guemes.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 400, estrellas4: 80, estrellas3: 10, estrellas2: 5, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '8',
            nombreUsuario: 'Tomi López',
            avatarUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
            puntuacion: 5.0,
            comentario: 'Un museo fascinante que ofrece una visión profunda de la historia argentina.',
            fecha: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
      AttractionModel(
        id: '7',
        titulo: 'teatro provincial de salta',
        descripcion: 'El Teatro Provincial de Salta es un emblemático teatro ubicado en la ciudad de Salta, Argentina. Este teatro es conocido por su arquitectura impresionante y su importancia cultural en la región. El edificio del teatro presenta un estilo neoclásico con detalles ornamentales que lo convierten en una joya arquitectónica. En su interior, el teatro cuenta con una sala principal que puede albergar a cientos de espectadores, así como espacios para exposiciones y eventos culturales. El Teatro Provincial de Salta es un centro cultural vital para la ciudad, ofreciendo una variedad de espectáculos que incluyen obras de teatro, conciertos, ballet y otras presentaciones artísticas.',
        promedioEstrellas: 4.0,
        cantidadVotos: 400,
        direccion: 'Calle Falsa 321, Salta',
        imageUrls: [
          'https://viapais.com.ar/resizer/x8MudWfWX-0w5LfJ8rmKxmbFeEk=/980x640/smart/filters:quality(75):format(webp)/cloudfront-us-east-1.images.arcpublishing.com/grupoclarin/IPUSVM6XVJFI7OY47KVLSXTFTQ.jpg',
          'https://www.argentina.gob.ar/sites/default/files/styles/large/public/2020-01/teatro-provincial-de-salta.jpg?itok=4n7sXo8h',
          'https://www.viajarar.com/wp-content/uploads/2019/11/teatro-provincial-de-salta.jpg',
        ],
        estadisticasVotos: RatingStats(estrellas5: 200, estrellas4: 150, estrellas3: 30, estrellas2: 15, estrellas1: 5),
        comentarios: [
          ReviewModel(
            id: '9',
            nombreUsuario: 'Yamil Homero',
            avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
            puntuacion: 4.0,
            comentario: 'Excelente teatro con una gran variedad de presentaciones.',
            fecha: DateTime.now().subtract(const Duration(days: 3)),
          ),
        ],
      ),
    ];
  }

  Future<List<AttractionModel>> _fetchGoogleApiAttractions(String categoryId) async {
    // Aquí iría tu lógica real haciendo una petición HTTP a la API de Google Places.
    // Tendrás que mapear el JSON que te devuelva Google a tu AttractionModel.
    
    return [
      
    ];
  }
}