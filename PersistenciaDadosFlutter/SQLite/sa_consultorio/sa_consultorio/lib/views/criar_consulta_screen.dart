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

  _dataSelecionada(BuildContext context) async {
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

  _horaSelecionada(BuildContext context) async {
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

  _salvarConsulta() async {
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
        pacienteId: widget 
      )
    }
  }
}
