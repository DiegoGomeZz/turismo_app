import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores de texto para capturar los datos ingresados
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _direccionController = TextEditingController();
  final _precioController = TextEditingController();
  final _imageUrlController = TextEditingController();

  // Estado para la fecha del evento (es opcional)
  DateTime? _fechaEvento;

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _direccionController.dispose();
    _precioController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // Selector de fecha nativo
  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fechaEvento) {
      setState(() {
        _fechaEvento = picked;
      });
    }
  }

  void _guardarFormulario() {
    if (_formKey.currentState!.validate()) {
      // Creamos el objeto AttractionModel asignando valores por defecto a los campos analíticos
      final nuevaAtraccion = AttractionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Generación de ID único local básico
        titulo: _tituloController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        imageUrls: _imageUrlController.text.isNotEmpty ? [_imageUrlController.text.trim()] : [],
        promedioEstrellas: 0.0, // Inicia sin calificación
        cantidadVotos: 0,       // Inicia sin votos
        fechaEvento: _fechaEvento, // Puede ser null si no es un evento cronológico
        direccion: _direccionController.text.trim(),
        precio: double.tryParse(_precioController.text) ?? 0.0,
        estadisticasVotos: RatingStats(
          estrellas5: 0,
          estrellas4: 0,
          estrellas3: 0,
          estrellas2: 0,
          estrellas1: 0,
        ),
        comentarios: [], // Lista inicial vacía
      );

      // TODO: Aquí debes conectar con tu HomeController para guardar la instancia
      // Ejemplo: context.read<HomeController>().agregarDestino(nuevaAtraccion);

      Navigator.pop(context); // Regresa a la HomeScreen
    }
  }

  // Estilo unificado para los campos de texto basado en tu HomeScreen
  InputDecoration _buildInputDecoration({required String hintText, IconData? prefixIcon}) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.black54) : null,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black12, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black45, width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Agregar Destino o Evento',
          style: TextStyle(
            color: Color.fromARGB(255, 17, 17, 17),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Text(
                'Detalles básicos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _tituloController,
                decoration: _buildInputDecoration(hintText: 'Título', prefixIcon: Icons.title),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa un título válido' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descripcionController,
                maxLines: 4,
                decoration: _buildInputDecoration(hintText: 'Descripción del destino'),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa una descripción' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _direccionController,
                decoration: _buildInputDecoration(hintText: 'Dirección o ubicación', prefixIcon: Icons.location_on),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa la ubicación' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _precioController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _buildInputDecoration(hintText: 'Precio (Opcional, dejar 0 si es gratis)', prefixIcon: Icons.attach_money),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imageUrlController,
                decoration: _buildInputDecoration(hintText: 'URL de la imagen', prefixIcon: Icons.image),
              ),
              const SizedBox(height: 24),

              const Text(
                '¿Es un evento temporal?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 12),

              // Selector de Fecha estilizado
              Card(
                elevation: 0,
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.black12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _fechaEvento == null 
                            ? 'No se ha definido fecha' 
                            : 'Fecha: ${_fechaEvento!.day}/${_fechaEvento!.month}/${_fechaEvento!.year}',
                        style: TextStyle(
                          color: _fechaEvento == null ? Colors.black54 : Colors.black87,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _seleccionarFecha(context),
                        icon: const Icon(Icons.calendar_today, size: 18),
                        label: Text(_fechaEvento == null ? 'Asignar Fecha' : 'Modificar'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _guardarFormulario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}