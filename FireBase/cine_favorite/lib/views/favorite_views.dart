import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteViews extends StatefulWidget {
  const FavoriteViews({super.key});

  @override
  State<FavoriteViews> createState() => _FavoriteViewsState();
}

class _FavoriteViewsState extends State<FavoriteViews> {
  //atributos
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // controlar a autenticação do usuário no Firebase

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Filmes Favoritos")));
  }
}
