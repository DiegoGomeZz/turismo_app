import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:turismo_app/features/profile/providers/auth_provider.dart';
import 'package:turismo_app/features/profile/views/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final user = authProvider.user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${user?.name ?? ''} ${user?.lastname ?? ''}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            color: Colors.white,
            onSelected: (value) {
              _handleMenuAction(context, value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',

                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),

                    SizedBox(width: 10),

                    Text('Editar perfil'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Cerrar sesión'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProfileCard(user),
          const SizedBox(height: 30),
          _buildPlaceholderSection(),
        ],
      ),
    );
  }

  Widget _buildProfileCard(dynamic user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(20, 0, 0, 0),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color.fromARGB(255, 220, 220, 220),
            backgroundImage: user?.image != null
                ? NetworkImage(user!.image!)
                : null,
            child: user?.image == null
                ? const Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          ),

          const SizedBox(height: 24),
          Text(
            '${user?.name ?? ''} ${user?.lastname ?? ''}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            user?.email ?? '',
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),

          const SizedBox(height: 8),
          Text(
            user?.phone ?? '',
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 42, color: Colors.black54),
          SizedBox(height: 16),
          Text(
            'Próximamente vas a poder guardar tus atracciones favoritas.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Armá tu propia colección de lugares para visitar más tarde.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuAction(BuildContext context, String value) async {
    final authProvider = context.read<AuthProvider>();
    switch (value) {
      case 'edit':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditProfileScreen()),
        );
        break;

      case 'logout':
        await authProvider.logout();
        if (!context.mounted) return;
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
    }
  }
}
