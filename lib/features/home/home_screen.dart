import 'package:flutter/material.dart';
import 'package:turismo_app/models/categoria_model.dart';
import 'package:turismo_app/widgets/categoria_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Categoria> misCategorias = [
      Categoria(nombre: 'Gastronomía', imagen: 'assets/images/gastronomia.jpg'),
      Categoria(nombre: 'Cerros', imagen: 'assets/images/cerros.jpg'),
      Categoria(nombre: 'Museos', imagen: 'assets/images/museos.jpg'),
      Categoria(nombre: 'Escalada', imagen: 'assets/images/escalada.jpg'),
    ];

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
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 15.0), 
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text('Destino $index')),
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

          ...misCategorias.map((cat) => CategoriaCard(categoriaModel: cat)).toList(),
        ],
      )
    );
  }

  /*Widget _buildCategoriaCard(String texto, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }*/
}