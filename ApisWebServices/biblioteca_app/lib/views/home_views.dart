import 'package:biblioteca_app/views/emprestimos/emprestimo_list_view.dart';
import 'package:biblioteca_app/views/livros/livros_list_views.dart';
import 'package:biblioteca_app/views/usuarios/usuario_list_view.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatefulWidget {
  const HomeViews({super.key});

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  // atributos de navegação
  int _index = 0;
  final List<Widget> _paginas = [
    const LivrosListViews(),
    const EmprestimoListView(),
    const UsuarioListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciador de biblioteca")),
      body: _paginas[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() {
          _index = i;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Livros"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: "Empréstimos"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Usuários"),
        ],
      ),
    );
  }
}
