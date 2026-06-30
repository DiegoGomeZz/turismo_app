import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:turismo_app/features/profile/controllers/auth_provider.dart';
import 'package:turismo_app/features/profile/enums/auth_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController lastnameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    nameController = TextEditingController(text: user?.name ?? '');
    lastnameController = TextEditingController(text: user?.lastname ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.updateUser(
        name: nameController.text.trim(),
        lastname: lastnameController.text.trim(),
        phone: phoneController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Perfil actualizado')));

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoading = authProvider.authState == AuthState.loading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Editar perfil'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildInput(controller: nameController, hint: 'Nombre'),
            const SizedBox(height: 16),
            _buildInput(controller: lastnameController, hint: 'Apellido'),
            const SizedBox(height: 16),
            _buildInput(controller: phoneController, hint: 'Teléfono'),
            const SizedBox(height: 30),
            _buildSaveButton(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.black.withOpacity(0.03),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSaveButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Guardar cambios'),
      ),
    );
  }
}
