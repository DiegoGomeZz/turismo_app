import 'package:flutter/material.dart';
import 'package:turismo_app/models/atraction_event_model.dart';

class AtractionEventCard extends StatelessWidget {
  final AtractionEventModel atractionEventModel;

  const AtractionEventCard({super.key, required this.atractionEventModel});

  @override
  Widget build(BuildContext context) {
    final int starCount = atractionEventModel.estrellas ?? 0;
    final String imagePath = atractionEventModel.imageUrl ?? 'assets/images/imagen_prueba.jpg';

    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        /*boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],*/
      ),
      // ClipRRect recorta el contenido del Stack para que respete los bordes curvos
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Imagen de fondo
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),

            // Titulo y Estrellas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 200,
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
                      atractionEventModel.titulo,
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
                            (index) => const Icon(Icons.star, color: Colors.yellow, size: 16),
                          ),
                          Text(
                            ' (${atractionEventModel.cantidadVotos} votos)',
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
    );
  }
}