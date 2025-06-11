import 'package:sa_consultorio/models/consulta_model.dart';
import 'package:sa_consultorio/services/db_helper.dart';


class ConsultaController {
  final _dbHelper = DbHelper();

  createConsulta(Consulta consulta) async{
    return _dbHelper.insertConsulta(consulta);
  }

  readConsultaByPaciente(int pacienteId) async {
    return _dbHelper.getConsultaByPacienteId(pacienteId);
  }

  deleteConsulta(int id) async{
   return _dbHelper.deleteConsulta(id);
  }
}