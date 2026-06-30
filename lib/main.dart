import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/core/widgets/main_screen.dart';
import 'package:turismo_app/features/home/controllers/attraction_detail_controller.dart';
import 'package:turismo_app/features/map/view_models/map_view_model.dart'; // 2. Importa tu ViewModel
import 'package:turismo_app/features/profile/controllers/auth_provider.dart';
import 'package:turismo_app/features/home/providers/attraction_detail_provider.dart';
import 'package:turismo_app/features/map/providers/map_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => AttractionDetailProvider()),
        // Aquí tu equipo podrá ir agregando los Providers de las otras features (home, profile, etc.)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
