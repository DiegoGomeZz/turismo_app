// features/map/views/map_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/map_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapVM = Provider.of<MapProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. EL MAPA DE GOOGLE (Capa base de fondo)
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-24.7859, -65.4116), // Centrado en Salta
              zoom: 14,
            ),
            markers: mapVM.markers, // Marcadores filtrados automáticamente desde el VM
            zoomControlsEnabled: false, // UI limpia sin botones nativos de +/-
            mapToolbarEnabled: false,
          ),

          // 2. BARRA DE BÚSQUEDA SUPERIOR
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: (value) => mapVM.updateSearchQuery(value),
                  decoration: const InputDecoration(
                    hintText: 'Buscar lugares turísticos...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),

          // 3. LISTVIEW HORIZONTAL DE CHIPS (Flotando abajo de la barra de búsqueda)
          Positioned(
            top: 115, 
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50, // Espacio suficiente para los chips con sombra
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                itemCount: mapVM.categories.length,
                itemBuilder: (context, index) {
                  final category = mapVM.categories[index];
                  final isSelected = mapVM.selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      avatar: _getCategoryIcon(category, isSelected),
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color.fromARGB(255, 0, 0, 0), // Color temático de tu App
                      backgroundColor: Colors.white,
                      elevation: 3,
                      pressElevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onSelected: (bool selected) {
                        if (selected) {
                          mapVM.selectCategory(category);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // 4. PANTALLA DE CARGA (Aparece de forma fluida si la API está trabajando)
          if (mapVM.isLoading)
            Container(
              color: Colors.black26, // Oscurece levemente el mapa bajo la carga
              child: const Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper estético para pintar los íconos dentro de cada tarjeta horizontal
  Widget? _getCategoryIcon(String category, bool isSelected) {
    IconData? iconData;
    if (category == 'Restaurantes') iconData = Icons.restaurant;
    if (category == 'Compras') iconData = Icons.local_mall;
    if (category == 'Hoteles') iconData = Icons.hotel;
    if (category == 'Histórico') iconData = Icons.account_balance;

    if (iconData == null) return null;
    return Icon(
      iconData, 
      size: 16, 
      color: isSelected ? Colors.white : Colors.grey[700]
    );
  }
}