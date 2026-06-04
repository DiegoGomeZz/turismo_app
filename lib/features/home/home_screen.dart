import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:turismo_app/models/atraction_event_model.dart';
import 'package:turismo_app/models/categoria_model.dart';
import 'package:turismo_app/widgets/categoria_card.dart';
import 'package:turismo_app/widgets/atraction_event_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Categoria> misCategorias = [
    Categoria(nombre: 'Gastronomía', imagen: 'assets/images/gastronomia.webp'),
    Categoria(nombre: 'Cerros', imagen: 'assets/images/cerros.webp'),
    Categoria(nombre: 'Museos', imagen: 'assets/images/museos.webp'),
    Categoria(nombre: 'Escalada', imagen: 'assets/images/escalada.webp'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 0, //para q no cambie el color del appbar cuando scrolleo
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
          const SizedBox(
            height: 10
          ),
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
              //150 de ancho + 15 de margen derecho = 165 exactos.
              itemExtent: 165.0,  //cambiar si en el futuro se cambia el ancho del contenedor o los espacios, para mantener la optimización de render
              itemBuilder: (context, index) {
                //Aislamiento de capas en los elementos que se scrollean
                return RepaintBoundary(
                  //Efecto Shimmer aplicado a los esqueletos de carga
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 150, // Se mantiene el ancho interno visual
                      margin: const EdgeInsets.only(right: 15.0), 
                      decoration: BoxDecoration(
                        color: Colors.white, // Debe ser blanco/sólido para que el shimmer brille sobre él
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

          //RepaintBoundary envolviendo cada tarjeta de categoría generada por el map
          ...misCategorias.map((cat) => RepaintBoundary(
            child: CategoriaCard(categoriaModel: cat)
          )).toList(),

          const SizedBox(height: 12),

          RepaintBoundary(
            child: AtractionEventCard(atractionEventModel: AtractionEventModel(
              titulo: 'Mueseo de arqueología de alta montaña de salta xd',
              descripcion: 'lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies lacinia, nunc nisl aliquam nisl, eget aliquam nunc nisl eget nunc.',
              estrellas: 5,
              cantidadVotos: 100,
              fechaEvento: DateTime.now(),
              imageUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/1b/4a/c2/c0/maam-museo-de-arqueologia.jpg',
            )),
          ),

        ],
      )
    );
  }
}