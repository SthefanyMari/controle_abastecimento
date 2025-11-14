import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'views/login_screen.dart';
import 'home/home_screen.dart';
import 'services/auth_service.dart';


import 'providers/veiculo_provider.dart';
import 'providers/abastecimento_provider.dart';


import 'screens/veiculos/veiculos_list_screen.dart';
import 'screens/veiculos/add_veiculo_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VeiculoProvider()),
        ChangeNotifierProvider(create: (_) => AbastecimentoProvider()),
      ],
      child: MaterialApp(
        title: 'Controle de Abastecimento',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),

       
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/veiculos': (context) => const VeiculosListScreen(),
          '/add_veiculo': (context) => const AddVeiculoScreen(),
        },

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
