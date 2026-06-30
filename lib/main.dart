import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Importa Provider
import 'package:turismo_app/core/widgets/main_screen.dart';
import 'package:turismo_app/features/home/controllers/attraction_detail_controller.dart';
import 'package:turismo_app/features/map/view_models/map_view_model.dart'; // 2. Importa tu ViewModel
import 'package:turismo_app/features/profile/controllers/auth_provider.dart';

void main() {
  runApp(
    // 3. Envolvemos la app en un MultiProvider para escalabilidad
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapViewModel()),
        ChangeNotifierProvider(create: (_) => AttractionDetailController()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Aquí tu equipo podrá ir agregando los ViewModels de las otras features (home, profile, etc.)
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
