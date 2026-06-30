import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/features/home/views/widgets/create_event_button.dart';
import '../providers/home_provider.dart';
import 'widgets/category_card.dart';
import 'package:turismo_app/features/home/views/widgets/vertical_attraction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

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
            'Eventos populares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 12),
          
          SizedBox(
            height: 260,
            child: Builder(
              builder: (context) {
                final destinos = homeProvider.destinosPopulares; 
                
                if (destinos.isEmpty) {
                  return const Center(child: CircularProgressIndicator()); 
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: destinos.length,
                  itemBuilder: (context, index) {
                    final destino = destinos[index];
                    return RepaintBoundary(
                      child: VerticalAttractionCard(attractionModel: destino),
                    );
                  },
                );
              }
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            'Categorías',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 12),

          ...homeProvider.categorias.map((cat) => RepaintBoundary(
            child: CategoryCard(categoriaModel: cat)
          )).toList(),
          
        ],
      ),

      floatingActionButton: const CreateEventButton(),

    );
  }
}

