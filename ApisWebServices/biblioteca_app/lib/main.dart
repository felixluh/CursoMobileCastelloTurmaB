import 'package:biblioteca_app/views/home_views.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Biblioteca",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.pink,
      useMaterial3: true
      ),
      home: HomeViews(),
  ));
}
