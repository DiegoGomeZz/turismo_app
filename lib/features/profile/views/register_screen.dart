import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/features/profile/providers/auth_provider.dart';
import 'package:turismo_app/features/profile/enums/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.register(
      name: nameController.text.trim(),
      lastname: lastnameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al registrarse. Por favor, revisá tus datos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final isLoading = authProvider.authState == AuthState.loading;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: ListView(
          children: [
            const Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Registrate para comenzar',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 40),
            _buildInput(controller: nameController, hint: 'Nombre'),
            const SizedBox(height: 16),
            _buildInput(controller: lastnameController, hint: 'Apellido'),
            const SizedBox(height: 16),
            _buildInput(controller: emailController, hint: 'Email'),
            const SizedBox(height: 16),
            _buildInput(controller: phoneController, hint: 'Teléfono'),
            const SizedBox(height: 16),

            _buildInput(
              controller: passwordController,

              hint: 'Contraseña',

              isPassword: true,
            ),

            const SizedBox(height: 16),

            _buildInput(
              controller: confirmPasswordController,

              hint: 'Confirmar contraseña',

              isPassword: true,
            ),

            const SizedBox(height: 30),

            _buildRegisterButton(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,

    required String hint,

    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,

      obscureText: isPassword,

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

  Widget _buildRegisterButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton(
        onPressed: isLoading ? null : _register,

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
            : const Text('Crear cuenta'),
      ),
    );
  }
}
