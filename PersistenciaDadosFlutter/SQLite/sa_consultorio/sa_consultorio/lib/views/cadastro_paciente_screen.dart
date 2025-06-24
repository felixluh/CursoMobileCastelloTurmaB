import 'package:flutter/material.dart';
import 'package:sa_consultorio/controllers/paciente_controller.dart';
import 'package:sa_consultorio/models/paciente_model.dart';
import 'package:sa_consultorio/views/home_screen.dart';

class CadastroPacienteScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CadastroPacienteScreenState();
  }
} 

class _CadastroPacienteScreenState extends State<CadastroPacienteScreen>{
  final _formKey = GlobalKey<FormState>();
  final _pacienteController = PacienteController();

  late String _nome;
  late String _cpf;
  late String _telefone;
  late String _email;
  late DateTime _dataDeNascimento;

  void _dataSelecionada(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked = _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
  }
  }

  _salvarPaciente() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPaciente = Paciente(
        nome: _nome,
        cpf: _cpf,
        dataDeNascimento: _dataDeNascimento,
        telefone: _telefone,
        email: _email,
        id: null);
    await _pacienteController.createPaciente(newPaciente);
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Paciente"),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Nome do Paciente"),
              validator: (value) => value!.isEmpty ? "Campo Não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "CPF Do Paciente"),
              validator: (value) => value!.isEmpty ? "Campo Não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Telefone do Paciente"),
              validator: (value) => value!.isEmpty ? "Campo Não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Email do Paciente"),
              validator: (value) => value!.isEmpty ? "Campo Não Preenchido" : null,
              onSaved: (newValue) => _nome = newValue!,
            ),
            ElevatedButton(onPressed: _salvarPaciente, child: Text("Cadastrar"))
          ],
        )),)
    );
  }
}