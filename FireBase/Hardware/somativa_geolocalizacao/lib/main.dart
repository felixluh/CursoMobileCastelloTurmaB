// lib/main.dart (Versão Finalizada da Estrutura)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'services/location_service.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
// import 'firebase_options.dart'; // Lembre-se de configurar o Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, 
  );

  runApp(
    MultiProvider(
      providers: [
        // 1. Serviço de Autenticação (Novo!)
        ChangeNotifierProvider(create: (_) => AuthService()),
        // 2. Serviço de Localização (Já criado)
        ChangeNotifierProvider(create: (_) => LocationService()),
        // 3. (Adicionaremos o PontoService no próximo passo)
      ],
      child: const PontoApp(),
    ),
  );
}

class PontoApp extends StatelessWidget {
  const PontoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Gerencia a navegação entre Login/Home baseado no estado do Firebase
      home: Consumer<AuthService>(
        builder: (context, authService, _) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(), // Escuta o estado de login
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Se há usuário logado, vai para a Home
              if (snapshot.hasData) {
                return const HomeScreen();
              }
              // Se não há usuário logado, vai para a autenticação
              return const AuthScreen();
            },
          );
        },
      ),
    );
  }
}