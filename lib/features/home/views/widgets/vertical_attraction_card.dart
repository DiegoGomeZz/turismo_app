import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/features/home/views/attraction_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VerticalAttractionCard extends StatelessWidget {
  final AttractionModel attractionModel;

  const VerticalAttractionCard({super.key, required this.attractionModel});

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
        width: 200, 
        margin: const EdgeInsets.only(right: 15.0), // Margen a la derecha para el scroll horizontal
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo
              if (imagePath.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  memCacheHeight: 450, // Ajustado a la nueva altura aproximada (220 * 2)
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.grey, size: 30),
                        SizedBox(height: 8),
                        Text(
                          'Sin imagen',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.landscape, color: Colors.grey, size: 50),
                ),

              // Degradado y Texto
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Fuente un poco más pequeña para encajar a lo ancho
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(
                            starCount,
                            (index) => const Icon(Icons.star, color: Color.fromARGB(255, 255, 235, 59), size: 12),
                          ),
                          Expanded(
                            child: Text(
                              ' (${attractionModel.cantidadVotos})',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontFamily: 'Roboto',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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