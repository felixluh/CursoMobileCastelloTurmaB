import 'package:flutter/material.dart';
import 'package:sa_consultorio/controllers/paciente_controller.dart';
import 'package:sa_consultorio/models/paciente_model.dart';
import 'package:sa_consultorio/views/cadastro_paciente_screen.dart';
import 'package:sa_consultorio/views/detalhe_paciente_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //atributos
  final PacienteController _pacienteController = PacienteController();
  List<Paciente> _paciente = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    try {
      _paciente = await _pacienteController.readPacientes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")));
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consultório - Pacientes"),),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
            padding: EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: _paciente.length,
              itemBuilder: (context,index){
                final paciente = _paciente[index];
                return ListTile(
                  title: Text("${paciente.nome} - ${paciente.cpf}"),
                  subtitle: Text("${paciente.dataDeNascimento} - ${paciente.telefone} - ${paciente.email}"),
                  onTap: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>DetalhePacienteScreen(pacienteId: paciente.id!))),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar nome do Paciente",
        child: Icon(Icons.add),
        onPressed: () async  {
          await Navigator.push(context, 
            MaterialPageRoute(builder: (context) => CadastroPacienteScreen()));
        },
      ),
    );
  }
}