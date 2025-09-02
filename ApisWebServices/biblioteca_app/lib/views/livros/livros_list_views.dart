import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivrosListViews extends StatefulWidget {
  const LivrosListViews({super.key});

  @override
  State<LivrosListViews> createState() => _LivrosListViewsState();
}

class _LivrosListViewsState extends State<LivrosListViews> {
  //atributos
  final _buscarField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];
  final _controller = LivroController(); //controller para conectar movel/view
  List<LivroModel> _livros = []; //lista para guardar os livros
  bool _carregando = true; //bool para usar view

  @override
  void initState() {
    //carregar os dados antes da construção da tela
    super.initState();
    _load(); //método para carregar dados da api
  }

  _load() async {
    setState(() {
      _carregando = true;
    });

    try {
      _livros = await _controller.fetchAll();
      _livrosFiltrados = _livros;
    } catch (e) {
      //caso erro exibir para o usuário
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      //modifica a variavel para false - terminou de carregar
      _carregando = false;
    });
  }

  //método para filtrar livros pelo titulo e pelo autor
  void _filtrar() {
    //filtra da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState((){
      _livrosFiltrados = _livro.where((livros) {
        return livros.titulo.toLowerCase().contains(busca) || //filtra pelo titulo
               livros.autor.toLowerCase().contains(busca); //filtra pelo autor
      })toList(); //converte em Lista
    });
  }

  //criar método deletar
  void _delete(LivroModel livros) async {
    if (livros.id == null) return; //interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Deseja Realmente Excluir o Livro ${livros.titulo}"),
        actions: [
          TextButton(
            onPressed: ()=> Navigator.pop(context, false),
            child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: ()=> Navigator.pop(context, false),
              child: c)
        ],
      ))
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
