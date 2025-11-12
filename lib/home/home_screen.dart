import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Abastecimento'),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo! Usuário logado.'),
      ),
    );
  }
}
