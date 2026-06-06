import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/attraction_model.dart';

class AttractionDetailScreen extends StatelessWidget {
  final AttractionModel attraction;

  const AttractionDetailScreen({super.key, required this.attraction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atracción'),
      ),
      body: const Center(
        child: Text('Detalles de la atracción'),
      ),
    );
  }
}