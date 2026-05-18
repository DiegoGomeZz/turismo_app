import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0, //para q no cambie el color del appbar cuando scrolleo
        toolbarHeight: 130,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Mapa',
          style: TextStyle(
              color: Color.fromARGB(255, 17, 17, 17),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
          ),
        )
      )
    );
  }
}