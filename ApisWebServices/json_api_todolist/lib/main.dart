import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage()));
}

// Chama a mudança de estado
class TarefasPage extends StatefulWidget {
  //garantia de importancia da herança bem sucedida
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

//faz a construção da logia e da tela para mudança de estado
class _TarefasPageState extends State<TarefasPage> {
  //atributos
  List<Map<String, dynamic>> tarefas =
      []; //lista para armazenar a coleção de tarefas
  final TextEditingController _tarefasController =
      TextEditingController(); //controlar o textFild
  String baseUrl = "http://10.109.197.14:3008/tarefas"; //endereço da Api

  //métodos
  //iniciar a conexão antes de carregar atela
  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  //get -> buscr informções da bd
  void _carregarTarefas() async {
    try {
      // fazer uma conexão http ( Instalar a bibloteca http )
      //fazer uma solicitação get
      final response = await http.get(
        Uri.parse(baseUrl),
      ); //Uri.parse -> String em URL
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        setState(() {
          //atualiza o estado da página
          //convertendo a lista Json da dados em tarefas(item) por tarefas(item)
          tarefas = dados
              .map((item) => Map<String, dynamic>.from(item))
              .toList(); //mais dificil nucnca da erro
          //tarefas = dados.cast<Map<String, dynamic>>(); //mais facil, mas pode dar erro
          //tarefas = List<Map<String, dynamic>>.from(dados); //outra forma de fazer a conversão da lista
        });
      }
    } catch (e) {
      print("Erro ao carregar Tarefas: $e");
    }
  }

  //post (inserir)
  void _adicionarTarefa(String titulo) async {
    try {
      final tarefa = {"titulo": titulo, "concluida": false}; //Map->Dart
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/jason"},
        body: json.encode(tarefa), //Map/Dart -> Text/Json
      );
      if (response.statusCode == 201) {
        _tarefasController.clear();
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Adicionada com Sucesso")),
        );
      }
    } catch (e) {
      print("Erro ao inserir Tarefa: $e");
    }
  }

  //ptch ou put (atualizar)
  void _atualizarTarefa(String id, bool concluida) async {
    try {
      final statusTarefa = {"concluida": concluida};
      final response = await http.patch(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/jason"},
        body: json.encode(statusTarefa),
      );
      if (response.statusCode == 200) {
        _carregarTarefas();
      }
    } catch (e) {
      print("Erro ao Atualizar Tarefa: $e");
    }
  }

  //delete (deletar)
  void _removerTarefa(String id) async {
    try {
      //solicitação delete -> delete (url + id)
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        _carregarTarefas(); //já tem SetStatus
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Tarefa Removida com sucesso")));
      }
    } catch (e) {
      print("Erro ao remover Tarefa: $e");
    }
  }

  //build Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via Api")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefasController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10),
            Expanded(
              //operador ternário
              child: tarefas.isEmpty
                  ? Center(child: Text("Nunhuma Tarefas adicionada"))
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return ListTile(
                          // Elemento do meu listview
                          //leadind (checkbox) -ATualizar a Conclusão da Tarefa
                          leading: Checkbox(
                            value: tarefa["conluida"],
                            onChanged: (value) => _atualizarTarefa(
                              tarefa["id"],
                              tarefa["concluida"],
                            ),
                          ),
                          title: Text(tarefa["titulo"]),
                          subtitle: Text(
                            tarefa["concluida"] ? "Concluida" : "Pendente",
                          ),
                          trailing: IconButton(
                            onPressed: () => _removerTarefa(tarefa["id"]),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
