import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_app/features/profile/enums/auth_state.dart';
import 'package:turismo_app/features/profile/views/login_requiered_screen.dart';
import 'profile_screen.dart';
import '../controllers/auth_provider.dart';

class ProfileGate extends StatelessWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider =
        context.watch<AuthProvider>();

    switch (authProvider.authState) {

      case AuthState.loading:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );

      case AuthState.authenticated:
        return const ProfileScreen();

      case AuthState.unauthenticated:
        return const LoginRequiredScreen();
    }
  }
}