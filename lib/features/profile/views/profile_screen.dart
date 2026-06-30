import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/features/profile/controllers/auth_provider.dart';

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
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              // navegar a editar perfil
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(40, 0, 0, 0),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                      backgroundImage: user?.image != null
                          ? NetworkImage(user!.image!)
                          : null,
                      child: user?.image == null
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem('0', 'Destinos'),
                          _buildStatItem('0', 'Seguidores'),
                          _buildStatItem('0', 'Seguidos'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Text(
                  '${user?.name ?? ''} ${user?.lastname ?? ''}',

                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? '',

                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 8),

                Text(
                  user?.phone ?? '',

                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 50),

          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}
