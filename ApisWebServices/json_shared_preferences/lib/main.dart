import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: ConfigPage()));
}

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  //atributos
  bool temaescuro = false;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  void carregarPreferencias() async {
    final prefs = await SharedPreferemces.getInstance();
  }
}
