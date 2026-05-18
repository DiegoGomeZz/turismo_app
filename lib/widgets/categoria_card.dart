import 'package:flutter/material.dart';
import 'package:turismo_app/models/categoria_model.dart';

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
        image: DecorationImage(
          image: AssetImage(categoriaModel.imagen), 
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color.fromARGB(80, 0, 0, 0),
            BlendMode.darken
          ),
        ),
      ),
      child: Center(
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
    );
  }
}