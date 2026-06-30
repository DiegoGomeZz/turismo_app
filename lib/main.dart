import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/core/widgets/main_screen.dart';
import 'package:turismo_app/features/home/providers/attraction_detail_provider.dart';
import 'package:turismo_app/features/map/providers/map_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => AttractionDetailProvider()),
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
