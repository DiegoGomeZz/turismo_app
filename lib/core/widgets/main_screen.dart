import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/views/home_screen.dart';
import 'package:turismo_app/features/map/views/map_screen.dart';
import 'package:turismo_app/features/profile/views/profile_screen.dart';
import 'package:turismo_app/features/provisorio/views/provisorio_screen.dart';
import 'package:turismo_app/features/search/views/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  // Creamos una llave independiente para el navegador de cada pestaña para mantener su estado independientemente de las demás (por ejemplo, si estás en la pestaña de Home, haces scroll y luego cambias a Search, al volver a Home debería mantener el scroll donde lo dejaste).
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Creamos un Navigator para cada uno de los tabs. Esto permite que cada tab tenga su propia pila de navegación.
  Widget _buildTabNavigator(int index, Widget screen) {
    return Navigator(
      key: navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => screen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Usamos IndexedStack para mantener el estado de cada pantalla incluso cuando no está visible.
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildTabNavigator(0, const HomeScreen()),
          _buildTabNavigator(1, const SearchScreen()),
          _buildTabNavigator(2, const MapScreen()),
          _buildTabNavigator(3, const ProvisorioScreen()),
          _buildTabNavigator(4, const ProfileScreen()),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        height: 65, 
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        indicatorColor: Colors.transparent,
      
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentIndex,
      
        onDestinationSelected: (int index) {
        setState(() {
          currentIndex = index; // Actualiza y redibuja
        });
      },
      
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.black54),
            selectedIcon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search, color: Colors.black54),
            selectedIcon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined, color: Colors.black54),
            selectedIcon: Icon(Icons.location_on, color: Colors.black),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined, color: Colors.black54),
            selectedIcon: Icon(Icons.calendar_month, color: Colors.black),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.black54),
            selectedIcon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}