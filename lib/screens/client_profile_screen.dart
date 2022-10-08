import 'package:agencia_la/auth/auth.dart';
import 'package:agencia_la/colors.dart';
import 'package:agencia_la/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  void logout(BuildContext context) {
    Auth.clearCurrentUser();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const LoginScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AgenciaLaColors.background,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bem vindo(a), ${Auth.getCurrentUser()?.email}"),
              const SizedBox(height: 16),
              const Text("Você está logado(a)!"),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: ElevatedButton(
                  onPressed: () => logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AgenciaLaColors.primary,
                    foregroundColor: AgenciaLaColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}