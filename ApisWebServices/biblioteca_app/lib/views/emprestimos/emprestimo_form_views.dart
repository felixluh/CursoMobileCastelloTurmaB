import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo_model.dart';
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
  final _idLivroField = TextEditingController(); // controla o campo nome
  final _idUsuarioField = TextEditingController(); //controle o email

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      
      _idLivroField.text = widget.emprestimo!.tituloLivro;
      _idUsuarioField.text = widget.emprestimo!.email;
    }
  }

 //criar novo usuario
  void _criar() async{
    if(_formKey.currentState!.validate()){
      final emprestimoNovo = EmprestimoModel(
        id: DateTime.now().millisecond.toString(), //criar um ID
        idLivro: _idLivroField.text.trim(), 
        idUsuario: _idUsuarioField.text.trim());
      try {
        await _controller.create(emprestimoNovo);
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
      final emprestimoAtualizado = EmprestimoModel(
        id: widget.user!.id, //criar um ID
        idLivro: _idLivroField.text.trim(), 
        idUsuario: _idUsuarioField.text.trim());
      try {
        await _controller.update(emprestimoAtualizado);
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
          widget.user == null ? "Emprestimo Novo": "Editar Emprestimo"
        ),),
        body: Padding(padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
                TextFormField(
                  controller: _idLivroField,
                  decoration: InputDecoration(labelText: "Titulo do Livro"),
                  validator: (value) => value!.isEmpty ? "Informe o Titulo do Livro" : null,
                ),
                TextFormField(
                  controller: _idUsuarioField,
                  decoration: InputDecoration(labelText: "Nome do Usuário"),
                  validator: (value) => value!.isEmpty ? "Informe o Nome do Usuário": null,
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
