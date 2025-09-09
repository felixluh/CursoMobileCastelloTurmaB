//widget de autenticação de usuario que vai direcionar o usuario logado para as telas de navegação

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //direcionamento de telas dinâmico,
    // direciona o Usuario de acordo com as informações salvas no cache(snapshot)
    return StreamBuilder<User?>(
      // o Stream buider vai depender do usário existir ou não
      stream: FirebaseAuth.instance
          .authStateChanges(), //modifica o caminho ao mudar o estado para o usuário
      builder: (context, snapshot) {
        //se o Snapshot tem dados, siginifica que o usuário está logado
        if (snapshot.hasData) {
          return TarefasView();
        }
        //caso contrario
        return LoginView();
      }
    );
  }
}
