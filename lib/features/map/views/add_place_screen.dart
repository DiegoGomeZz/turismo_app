import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place_model.dart';
import '../view_models/map_view_model.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _addressController = TextEditingController();

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final mapVM = Provider.of<MapViewModel>(context, listen: false);
      
      final nuevoLugar = PlaceModel(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descController.text,
        address: _addressController.text,
        latitude: -34.6037 + (0.01), // Aquí simularás o capturarás la Lat del mapa
        longitude: -58.3816 + (0.01), // Aquí simularás o capturarás la Lng del mapa
      );

      mapVM.addPlace(nuevoLugar);
      Navigator.pop(context); // Volver al mapa
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Lugar Turístico')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Nombre del Lugar'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa la dirección' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descripción / Detalles'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa una descripción' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Guardar Lugar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}