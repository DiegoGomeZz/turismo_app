import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';

import '../controllers/home_controller.dart';
import 'widgets/category_card.dart';
 import 'widgets/attraction_card.dart'; // Descomentar cuando lo uses

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nos suscribimos al controlador
    final homeController = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 130,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Column(
          children: [
            const Text(
              'Turismo App',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 17, 17),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'buscar destinos, actividades, etc.',
                prefixIcon: const Icon(Icons.search),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.black12, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.black45, width: 2.0),
                ),
              ),
            ),
          ],
        ),
      ),
      
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), 
        children: [
          const Text(
            'Destinos populares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 12),
          
          SizedBox(
            height: 180, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemExtent: 165.0,
              itemBuilder: (context, index) {
                return RepaintBoundary(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 15.0), 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text('Destino $index')),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            'Categorias',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 12),

          // Pintamos los datos directamente sin preguntar si está cargando
          ...homeController.categorias.map((cat) => RepaintBoundary(
            child: CategoryCard(categoriaModel: cat)
          )).toList(),

          const SizedBox(height: 12),

          
          RepaintBoundary(
            child: AttractionCard(attractionModel: AttractionModel(
              titulo: 'museo de arqueología de alta montaña',
              descripcion: 'hola hola xdddddddddddddddddd',
              imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/1b/4a/c2/c0/maam-museo-de-arqueologia.jpg',
              estrellas: 5,
              cantidadVotos: 100,
              fechaEvento: DateTime.now(),)),
          ),
          
        ],
      )
    );
  }
}