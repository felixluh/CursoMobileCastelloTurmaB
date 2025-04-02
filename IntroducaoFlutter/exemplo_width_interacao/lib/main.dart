import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: TelaCadastroApp()));
}

//criar uma tela de Cadastro (formulário) - 
class TelaCadastroApp extends StatefulWidget{
  @override
  _TelaCadastroAppState createState() => _TelaCadastroAppState();
}

class _TelaCadastroAppState extends State<TelaCadastroApp>{
  //atributos
  final _formKey = GlobalKey<FormState>(); //Chave de Seleção dos Componenetes do Formulário
  String _nome = ""; //utilização do "_" antes da declaração da variavel (private)
  String _email = "";
  String _senha = "";
  String _genero = "";
  String _dataNascimento ="";
  double _experiencia = 0;
  bool _aceite = false; //declaração de boolean

  //métodos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadsatro de Usuario - Exemplo Widegt Interação")),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
        children: [
           //campo nome
           TextFormField(
            decoration: InputDecoration(labelText: "Insira o nome"),
            validator: (value) => value!.isEmpty ? "Digite um Nome": null, //oprador ternário
            onSaved: (value)=> _nome = value!.trim(),
           ),
          //campo email
            TextFormField(
            decoration: InputDecoration(labelText: "Insira o email"),
            validator: (value) => value!.contains("@") ? null: "Digite um email", //oprador ternário
            onSaved: (value)=> _email = value!.trim(),
           ),
           //campo senha
            TextFormField(
            decoration: InputDecoration(labelText: "Insira a senha"),
            obscureText: true,
            validator: (value) => value!.trim().length>=6 ? null: "Digite a senha valida", //oprador ternário
            onSaved: (value)=> _senha = value!.trim(),
           ),
           //campo genero
            Text("Gênero"),
            DropdownButtonFormField(
              items: ["Feminino", "Masculino", "Outro"].map((String genero)=>DropdownMenuItem(
                value: genero,
                child: Text(genero))).toList(),
                 onChanged: (value){},
                 validator: (value)=> value==null ? "Selecione um Gênero" : null,
                 onSaved: (value) => _genero = value! 
            ),
            //campo DatadeNascimento
            TextFormField(
              decoration: InputDecoration(labelText: "Informe a Data de Nascimento"),
              validator: (value) => value!.trim().isEmpty ? "Digite a Data de Nascimento": null,
              onSaved: (value)=> _dataNascimento = value!.trim(),
            ),
             //slider de Seleção(experiência)
              Text("Anos de Experiência com Programação:"),
              Slider(
                value: _experiencia,
                min: 0,
                max: 20,
                divisions: 20,
                label: _experiencia.round().toString(), 
                onChanged: (value)=>setState(() {
                  _experiencia = value;
                })),
                //aceite do termos de uso
                CheckboxListTile(
                  value: _aceite,
                  title: Text("Aceito os termos de uso do aplicativo"),
                  onChanged: (value)=>setState(() {
                    _aceite = value!;
                  })),
                  //botão de envio do formulario
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                   child: Text("Enviar"))
        ],
      ),))
    );
  }
void _enviarFormulario(){

}
}