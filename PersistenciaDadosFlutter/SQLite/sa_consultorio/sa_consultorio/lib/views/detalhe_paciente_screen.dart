import 'package:flutter/material.dart';
import 'package:sa_consultorio/controllers/consulta_controller.dart';
import 'package:sa_consultorio/controllers/paciente_controller.dart';
import 'package:sa_consultorio/models/consulta_model.dart';
import 'package:sa_consultorio/models/paciente_model.dart';
import 'package:sa_consultorio/views/criar_consulta_screen.dart';

class DetalhePacienteScreen extends StatefulWidget {
    final int pacienteId;

    DetalhePacienteScreen({super.key, required this.pacienteId});

    @override
    State<StatefulWidget. createState() {
        return _DetalhePacienteScreenState();
    }
}

class _DetalhePacienteScreenState extends State<DetalhePacienteScreen> {
    final _pacienteControl = PacienteController();
    final _consultasControl = ConsultaController();

    Paciente? _paciente;

    List<Consulta> _consultas = [];

    bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
      _consultas = [];
    });
    try {
      _paciente = await _pacienteControl.readPacientebyId(widget.pacienteId);
      _consultas = await _consultaControl.readConsultaByPet(widget.pacienteId);
    }
} catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe do Paciente"),),
      body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : _pet == null 
          ? Center(child: Text("Erro ao Carregar o Paciente, Verifique o ID"),) 
          : Padding(padding: EdgeInsets.all(16),child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("nome: ${_paciente!.nome}", style: TextStyle(fontSize: 20),),
              Text("cpf: ${_paciente!.cpf}"),
              Text("dataDeNascimento: ${_paciente!.dataDeNascimento}"),
              Text("telefone: ${_paciente!.telefone}"),
              Text("email: ${_paciente!.email}", style: TextStyle(fontSize: 20),),
              Divider(),
              Text("Consultas:", style: TextStyle(fontSize: 18),),
               _consultas.isEmpty
                ? Center(child: Text("Não Existe Consultas Agendadas"),)
                : Expanded(child: ListView.builder(
                  itemCount: _consultas.length,
                  itemBuilder: (context,index){
                    final consulta = _consultas[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(consulta.especialidade),
                        subtitle: Text(consulta.dataHoraLocal),
                      ),
                    );
                  }))
            ],
          ),),
           floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> CriarConsultaScreen(pacienteId: widget.pacienteId)));
          _carregarDados();
        },
        child: Icon(Icons.add),
      ), 
    );
  }