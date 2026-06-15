import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/features/home/views/attraction_detail_screen.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AttractionCard extends StatelessWidget {
  final AttractionModel attractionModel;

  const AttractionCard({super.key, required this.attractionModel});

  @override
  Widget build(BuildContext context) {
    final int starCount = attractionModel.promedioEstrellas.round();
    final String imagePath = attractionModel.coverImage;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttractionDetailScreen(attraction: attractionModel),
          ),
        );
      },
      child: Container(
        height: 175,
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      
        // ClipRRect recorta el contenido del Stack para que respete los bordes curvos
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              //Imagen de fondo
              if (imagePath.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  // OPTIMIZACIÓN DE RAM: (esta parte hecha con gemini)
                  // La altura lógica es 175. Multiplicamos aprox por 2 para pantallas de alta densidad (Retina/OLED).
                  // Flutter descartará cualquier resolución sobrante de la imagen original.
                  memCacheHeight: 350, 
                  
                  // Mientras la imagen se descarga de internet
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blueGrey, // Ajusta al color primario de tu app
                      ),
                    ),
                  ),
                  
                  // Si la URL está rota (ej: Google Maps cambió el link) o hay un error de red
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.grey, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Imagen no disponible',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                // Fallback visual si el evento directamente no tiene imagen en la base de datos
                Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.landscape, color: Colors.grey, size: 60),
                ),
      
              // Titulo y Estrellas
              Positioned.fill(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color.fromARGB(0, 0, 0, 0), Colors.black.withOpacity(0.9)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        attractionModel.titulo,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                            ...List.generate(
                              starCount,
                              (index) => const Icon(Icons.star, color: Color.fromARGB(255, 255, 235, 59), size: 16),
                            ),
                            Text(
                              ' (${attractionModel.cantidadVotos} votos)',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                            ),
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}