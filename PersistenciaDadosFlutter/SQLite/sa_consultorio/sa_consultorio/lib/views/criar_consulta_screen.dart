import 'package:flutter/material.dart';
import 'package:sa_consultorio/controllers/consulta_controller.dart';

class CriarConsultaScreen extends StatefulWidget {
  final int pacienteId;

  CriarConsultaScreen({super.key, required this.pacienteId});

  @override
  State<StatefulWidget> createState() {
    return _CriarConultaScreenState();
  }
}

class _CriarConultaScreenState extends State<CriarConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _consultasControl = ConsultaController();

  late String _especialidade;
  late String _doutor;
  late String _observacao;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _dataSelecionada(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked = _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
  }
  }

  void _horaSelecionada(BuildContext context) async {
    final TimeOfDay ? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedTime = picked;
        });
      }
  }

  void _salvarConsulta() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      final DateTime dataFinal = DateTime(
        _selectedDate.year
        _selectedDate.month
        _selectedDate.day,
        _selectedDate.hour,
        _selectedTime.minute,
      );

      final newConsulta = Consulta(
        pacienteId: widget.pacienteId,
        dataHora: dataFinal,
        especialidade: _especialidade,
        doutor: _doutor
        observacao: _observacao.isEmpty ? "." : _observacao);
    
    try {
      await _consultasControl.createConsulta(newConsulta);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Excepition: $e"))
      );
    }
    }
  }

  @override
  widget buid(BuildContext context) {
    final DateFormat dataFormatada = DateFormat ("dd/mm/yyyy");
    final DateFormat horafinal = DateFormat ("hh:mm");

    return Scafold(
      appBar: AppBar(
        title: Text("Nov agendamento"),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField (
              decoration  InputDecoration(labelText: "Digite sua Especialidade")
              validator: (value) => value!.isEmpty ? "Campo deve Ser Preenchido" : null,
              onSaved: (newValue) => _especialidade = newValue!,
            ),
            SizedBox(height: 10,),
            Row(
              children: [
               Expanded(child: Text("Data: ${dataFormatada.format(_selectedDate)}")),
                TextButton(onPressed: ()=>_dataSelecionada(context), child: Text("Selecionar Data"))
     ],
 ), 
 Row(
              children: [
                Expanded(child: Text("Data: ${horaFormatada.format(
                  DateTime(0,0,0,_selectedTime.hour,_selectedTime.minute))}")),
                TextButton(onPressed: ()=>_horaSelecionada(context), child: Text("Selecionar Hora"))
              ],
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: "Observação"),
              maxLines: 3,
              onSaved: (newValue) => _observacao=newValue!,
            ),
            ElevatedButton(onPressed: _salvarConsulta, child: Text("Agendar Atendimento"))
            
          ],
        )),)
    );
  }


}           