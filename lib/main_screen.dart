import 'package:flutter/material.dart';
import 'package:turismo_app/features/home/home_screen.dart';
import 'package:turismo_app/features/map/map_screen.dart';
import 'package:turismo_app/features/profile/profile_screen.dart';
import 'package:turismo_app/features/provisorio/provisorio_screen.dart';
import 'package:turismo_app/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),   // Índice 0
    const SearchScreen(), // Índice 1
    const MapScreen(),    // Índice 2
    const ProvisorioScreen(), // Índice 3
    const ProfileScreen(),// Índice 4
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

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