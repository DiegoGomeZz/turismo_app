import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/category_model.dart';
import 'package:turismo_app/features/home/providers/category_detail_provider.dart';
import 'package:turismo_app/features/home/views/widgets/create_event_button.dart';
import 'package:turismo_app/features/home/views/widgets/attraction_card.dart'; 

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel categoria;

  const CategoryDetailScreen({super.key, required this.categoria});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final CategoryDetailProvider _controller = CategoryDetailProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.fetchAttractionsByCategory(widget.categoria.nombre);

    _scrollController.addListener(() {     //oyente del scroll para la paginación
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) { // Si estamos a 200 pixeles del fondo de la lista
        _controller.fetchMoreAttractions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.categoria.nombre),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'buscar en ${widget.categoria.nombre.toLowerCase()}',
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
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          // Si está cargando la página 1 (borra todo)
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.errorMessage.isNotEmpty) {
            return Center(child: Text(_controller.errorMessage));
          }

          if (_controller.attractions.isEmpty) {
            return const Center(child: Text('Aún no hay atracciones en esta categoría.'));
          }

          return RefreshIndicator(
            onRefresh: () => _controller.fetchAttractionsByCategory(widget.categoria.nombre),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
              // Sumamos 1 al itemCount si está cargando más datos para mostrar la ruedita abajo
              itemCount: _controller.attractions.length + (_controller.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                
                // Si el índice es igual al tamaño de la lista, renderizamos el indicador de carga
                if (index == _controller.attractions.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final atraccion = _controller.attractions[index];

                return AttractionCard(attractionModel: atraccion);
                
              },
            ),
          );
        },
      ),
      floatingActionButton: const CreateEventButton(),
    );
  }
}