//clsse para genciar orelacionamento do modello com a interface
import 'dart:io';
import 'package:cine_favorite/modells/favorite_movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FavoriteMovieController {
  //atributos
  final _auth = FirebaseAuth.instance; // conecta com Auth do FireBase
  final _db = FirebaseFirestore.instance; //concta com o FireStore

  //Criar em User => método para busar o usuário logado
  User? get currentUser => _auth.currentUser;

  //métodos para o Favorite Movie

  //addFavorite
  void addavorite(Map<String, dynamic> movieData) async {
    //uasr bibliotecas path e path_provider para armazenar a img no celular
    //baixar a imagem da internet
    final imagemUrl =
        "https://image.tmdb.org/t/p/w500${movieData['poster_path']}";
    final responseImg = await http.get(Uri.parse(imagemUrl));
    //armazernar a imagem no celular
    final imagemDir = await getApplicationCacheDirectory();
    final imagemFile = File("${imagemDir.path}/${movieData["id"]};jpg");
    await imagemFile.writeAsBytes(responseImg.bodyBytes);

    //criar o obj FavoriteMovie
    final movie = FavoriteMovie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: imagemFile.path.toString(),
    );

    //adicionar o obj ao firebase
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  //listFavorite => pagar A LISTA DE FILMES O BD
  //Stream => listener, pa ga lista de favoritos senpre qye for nodificada
  Stream<List<FavoriteMovie>> getFavoriteMovies() {
    //verifica se o usuario existe
    if (currentUser == null)
      return Stream.value([]); //retorna alista vazia caso nção tenha usuário

    return _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FavoriteMovie.fromMap(doc.data()))
              .toList(),
        );
  }

  //removeFavorite
  void removeFavoriteMovie(int movieId) async {
    if (currentUser == null) return;

    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .delete();

    //deletar a imagem do celular
    final imagemPath = await getApplicationCacheDirectory();
    final imagemFile = File("${imagemPath.path}/$movieId.jpg");
    try {
      await imagemFile.delete();
    } catch (e) {
      print("Erro ao deletar a imagem: $e");
    }
  }

  //updateRating
  void updateMovieRating(int movieId, double rating) async {
    if (currentUser == null) return;

    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .update({"rating": rating});
  }

  void removeFavorite(int id) {}

  void updateRating(int id, double newRating) {}
}
