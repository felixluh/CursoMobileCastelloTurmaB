import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  //atributos
  final PacienteController _pacienteController = PacienteController();
  List<Paciente> _pacientes = [];

}