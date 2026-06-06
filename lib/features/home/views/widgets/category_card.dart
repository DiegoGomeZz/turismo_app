import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/category_model.dart';

class CategoriaCard extends StatelessWidget {
  final Categoria categoriaModel;

  const CategoriaCard({super.key, required this.categoriaModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300], // Fondo de carga
      ),
      child: ClipRRect( // Para redondear las esquinas de la imagen
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              categoriaModel.imagen,
              fit: BoxFit.cover,
              // --- OPTIMIZACIÓN imagen (hecho con gemini )
              // Le dice al motor de Flutter que ignore la resolución real del JPG
              // y lo decodifique en RAM con un alto máximo de 400px (200px lógicos * 2 de densidad).
              // Esto elimina el lag de scroll instantáneamente.
              cacheHeight: 400, 

              color: const Color.fromARGB(80, 0, 0, 0),
              colorBlendMode: BlendMode.darken,
            ),
            
            Center(
              child: Text(
                categoriaModel.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}