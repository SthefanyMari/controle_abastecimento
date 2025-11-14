import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../views/login_screen.dart';
import '../screens/veiculos/veiculos_list_screen.dart'; // IMPORT CORRETO

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
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      /// 🌟 AQUI ESTÁ A TELA COM O BOTÃO PARA VEÍCULOS
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo! Usuário logado.'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VeiculosListScreen(),
                  ),
                );
              },
              child: const Text("Gerenciar Veículos"),
            ),
          ],
        ),
      ),
    );
  }
}
