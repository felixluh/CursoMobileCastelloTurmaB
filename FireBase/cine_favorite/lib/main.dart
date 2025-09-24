import 'package:cine_favorite/views/favorite_views.dart';
import 'package:cine_favorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //garantir o carregamento das widgets primeiro
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o firebase
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: "Cine Favorite",
      theme: ThemeData(
        primaryColor: Colors.purple,
        brightness: Brightness.dark,
      ),
      home:
          AuthStream(), //permite a navegação de tela de acordo com alguma decisão
    ),
  );
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    //ouvinte da mudança de status (listener)
    return StreamBuilder<User?>(
      //ouvinte da mudança de status do usuário?
      //ouvinte da mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(),
      //identifica a mudança de status do usuario(logado ou não)
      builder: (context, snapshot) {
        //analisa oinstâneo da aplicação
        //se tiver logdo vai para a tela defavoritos
        if (snapshot.hasData) {
          return FavoriteViews();
        } //caso contrario => tela de login
        return LoginView();
      },
    );
  }
}
