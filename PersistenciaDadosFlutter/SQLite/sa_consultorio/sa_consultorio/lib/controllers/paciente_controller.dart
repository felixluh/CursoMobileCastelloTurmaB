import 'package:sa_consultorio/models/paciente_model.dart';
import 'package:sa_consultorio/services/db_helper.dart';


class PacienteController {
  final DbHelper _dbHelper = DbHelper();

  Future<int> createPaciente(Paciente paciente) async{
    return await _dbHelper.insertPaciente(paciente);
  }

  Future<List<Paciente>> readPacientes() async {
    return await _dbHelper.getPacientes();
  }

  Future<Paciente?> redPacienteById(int id) async{
    return await _dbHelper.getPacientebyId(id);
  }

  Future<int> deletePaciente(int id) async {
    return await _dbHelper.deletePaciente(id);
  }
}