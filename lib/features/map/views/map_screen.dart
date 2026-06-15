import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view_models/map_view_model.dart';
import 'add_place_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapVM = Provider.of<MapViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. El Mapa de Google
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-34.6037, -58.3816), // Coordenadas por defecto (ej. BsAs)
              zoom: 12,
            ),
            markers: mapVM.markers,
            myLocationButtonEnabled: false,
          ),

          // 2. Barra de Búsqueda Superior
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
        ],
      ),
      
      // 3. Botón para añadir un nuevo lugar
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlaceScreen()),
          );
        },
        label: const Text('Nuevo Lugar'),
        icon: const Icon(Icons.add_location_alt),
      ),
    );
  }
}