import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/models/category_model.dart';

class HomeController extends ChangeNotifier {

  final List<CategoryModel> _categorias = const [
    CategoryModel(nombre: 'Gastronomía', imagen: 'assets/images/gastronomia.webp'),
    CategoryModel(nombre: 'Cerros', imagen: 'assets/images/cerros.webp'),
    CategoryModel(nombre: 'Museos', imagen: 'assets/images/museos.webp'),
    CategoryModel(nombre: 'Escalada', imagen: 'assets/images/escalada.webp'),
  ];


  List<CategoryModel> get categorias => _categorias;
}