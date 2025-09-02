import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/views/emprestimos/emprestimo_form_view.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  //atributos
  final _buscarField = TextEditingController();
  List<EmprestimoModel> _emprestimosFiltrados = [];
  final _controller = EmprestimoController(); //controller para conectar movel/view
  List<EmprestimoModel> _emprestimo = []; //lista par guardar os usuário
  bool _carregando = true; //bool par usar no view

  @override
  void initState() {
    // carregar os dados antes da contrução da tela
    super.initState();
    _load(); //método par carregar dados da api
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _emprestimo = await _controller
          .fetchAll(); //preenche a lista de usuário com os usuario do BD
      _emprestimosFiltrados = _emprestimo;
    } catch (e) {
      //caso erro mostra para o usuário
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      // modifica a variável para false - terminou de carregar
      _carregando = false;
    });
  }

  //método para filtrar usuários pelo nome e pelo email
  void _filtrar() {
    //filtar da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _emprestimosFiltrados = _emprestimo.where((emprestimo) {
        return emprestimo.idLivro.toLowerCase().contains(busca) || //filtra pelo id do Livro
            emprestimo.idUsuario.toLowerCase().contains(busca); //filtra pelo id do Usuário
      }).toList(); //converte em Lista
    });
  }

  //criar método deletar
  void _delete(EmprestimoModel user) async {
    if (emprestimo.id == null) return; //interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Deseja Realmente Excluir o Usuario ${emprestimo.idLivro}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Confirmar"),
          ),
        ],
      ),
    );
    if (confirme == true) {
      try {
        await _controller.delete(user.id!);
        _load();
        //mensagem de confirmação
      } catch (e) {
        //tratar erro
      }
    }
  }

  //método para navegar para a tela user_form_view
  void _openForm({UsuarioModel? user}) async {
    //usuário entra no parâmetro mas não é obrgatório
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioFormView(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // operador ternário
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            ) // mostra uma barra circular
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: InputDecoration(labelText: "Pesquisar Usuário"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    // ,mostra a lista de usuário
                    padding: EdgeInsets.all(8),
                    itemCount: _usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = _usuariosFiltrados[index];
                      return Card(
                        child: ListTile(
                          //leadind
                          leading: IconButton(
                            onPressed: ()=>_openForm(user: usuario),
                            icon: Icon(Icons.edit)),
                          title: Text(usuario.nome),
                          subtitle: Text(usuario.email),
                          //trailing para deletar usuario
                          trailing: IconButton(
                            onPressed: ()=> _delete(usuario),
                             icon: Icon(Icons.delete, color: Colors.red,)),
                        ),
                      );
                    }),
                ),
              ],
            ),
   floatingActionButton: FloatingActionButton(
    onPressed: ()=> _openForm(),
    child: Icon(Icons.add),
   )
    );
  }
}
