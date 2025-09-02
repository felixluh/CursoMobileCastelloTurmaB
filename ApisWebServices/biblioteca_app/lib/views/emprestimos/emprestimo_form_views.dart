import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:flutter/material.dart';

class EmprestimoFormViews extends StatefulWidget {
  //atributos da classe
  final EmprestimoModel? user; //pode ser nulo

  const EmprestimoFormViews({
    super.key,
    this.user,
  }); //usuário não é obrigatório no construtor

  @override
  State<EmprestimoFormViews> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimoFormViews> {
  //atributos
  final _formKey = GlobalKey<FormState>(); // validação do formulário
  final _controller = EmprestimoController(); // comunicação entre view e model
  final _tituloLivroField = TextEditingController(); // controla o campo nome
  final _nomeUsuarioField = TextEditingController(); //controle o email

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      
      _tituloLivroField.text = widget.emprestimo!.tituloLivro;
      _nomeUsuarioField.text = widget.emprestimo!.email;
    }
  }

 //criar novo usuario
  void _criar() async{
    if(_formKey.currentState!.validate()){
      final usuarioNovo = UsuarioModel(
        id: DateTime.now().millisecond.toString(), //criar um ID
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim());
      try {
        await _controller.create(usuarioNovo);
        //mensagem de criação do usuário
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context); //volta pra tela anterio
    }
  }

  //atualizar utuário
  void _atualizar() async{
    if(_formKey.currentState!.validate()){
      final usuarioAtualizado = UsuarioModel(
        id: widget.user!.id, //criar um ID
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim());
      try {
        await _controller.update(usuarioAtualizado);
        //mensagem de atualização do usuário
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context); //volta pra tela anterio
    }
  }


//build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //operador ternário
          widget.user == null ? "Novo Usuário": "Editar Usário"
        ),),
        body: Padding(padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
                TextFormField(
                  controller: _nomeField,
                  decoration: InputDecoration(labelText: "Nome"),
                  validator: (value) => value!.isEmpty ? "Informe o Nome" : null,
                ),
                TextFormField(
                  controller: _emailField,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) => value!.isEmpty ? "Informe o Email": null,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: widget.user == null ? _criar : _atualizar,
                  child: Text(widget.user == null ? "Salvar": "Atualizar"),
                  )
            ],
          )),
        ),
    );
  }
}
