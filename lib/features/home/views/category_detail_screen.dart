import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/category_model.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';
import 'package:turismo_app/features/home/controllers/category_detail_controller.dart';
import 'package:turismo_app/features/home/views/widgets/attraction_card.dart';
import 'package:turismo_app/features/home/views/widgets/create_event_button.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel categoria;

  const CategoryDetailScreen({super.key, required this.categoria});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final CategoryDetailController _controller = CategoryDetailController();
  final ScrollController _scrollController = ScrollController();
  
  // Estados para manejar los datos y la UI
  List<AttractionModel> _atracciones = [];
  bool _isLoadingFirstTime = true; // Para la carga inicial
  bool _isLoadingMore = false;     // Para la ruedita al final del scroll
  bool _hasMoreData = true;        // Para saber si ya no hay más elementos en la BD
  int _currentPage = 1;            // Página actual

  @override
  void initState() {
    super.initState();
    _fetchInitialData();

    // Agregamos un listener al scroll para detectar cuándo llegamos abajo
    _scrollController.addListener(() {
      // Si estamos a 200 pixeles del final, no estamos ya cargando, y hay más datos
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMore && _hasMoreData) {
          _fetchMoreData();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); //Liberar memoria
    super.dispose();
  }


  Future<void> _fetchInitialData() async {
    setState(() => _isLoadingFirstTime = true);
    
    try {
      final data = await _controller.getAttractionsByCategory(widget.categoria.id.toString(), page: 1);
      setState(() {
        _atracciones = data;
        _isLoadingFirstTime = false;
        if (data.length < 10) _hasMoreData = false; 
      });
    } catch (e) {
      setState(() => _isLoadingFirstTime = false);
    }
  }

  Future<void> _fetchMoreData() async {
    setState(() => _isLoadingMore = true);
    _currentPage++;

    try {
      final newData = await _controller.getAttractionsByCategory(widget.categoria.id.toString(), page: _currentPage);
      setState(() {
        _atracciones.addAll(newData);
        _isLoadingMore = false;
        if (newData.isEmpty || newData.length < 10) _hasMoreData = false;
      });
    } catch (e) {
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    _hasMoreData = true;
    await _fetchInitialData();
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
            child: Column(
              children: [
                TextField(
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
              ],
            ),
          ),
        ),
      ),
      body: _isLoadingFirstTime
          ? const Center(child: CircularProgressIndicator()) // Carga inicial
          : _atracciones.isEmpty
              ? const Center(child: Text('Aún no hay atracciones en esta categoría.')) // Lista vacía
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController, // Vinculamos el controlador
                    padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16), // Espacio para el loader
                    // Le sumamos 1 al itemCount si estamos cargando más, para mostrar el loader al final
                    itemCount: _atracciones.length + (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      
                      // Si el índice es igual al tamaño de la lista, significa que es el último elemento adicional (el loader)
                      if (index == _atracciones.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final atraccion = _atracciones[index];
                      return AttractionCard(attractionModel: atraccion);
                    },
                  ),
                ),

                floatingActionButton: const CreateEventButton(),
    );
  }
}