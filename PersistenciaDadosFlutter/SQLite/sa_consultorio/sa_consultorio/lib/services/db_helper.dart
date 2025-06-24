import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sa_consultorio/models/consulta_model.dart';
import 'package:sa_consultorio/models/paciente_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqlite_api.dart'

class DbHelper {
  static Database? _database;

  static final DbHelper _instance = DbHelper._internal();

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database> get database async{
    if (_database != null) {
      return _database!;
    }else{
      _database = await _intDatabase();
      return _database!;
    }
  }

  Future<Database> _intDatabase() async{
    final dbPath = await getDatabasePath();
    final path = join(dbPath, "consultorio.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB
    );
  }

  Future<void> _onCreateDB(Database db, int version) async{
    await db.execute(
      """CREATE TABLE IF NOT EXISTS pacientes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      cpf TEXT NOT NULL,
      dataDeNascimento TEXT NOT NULL,
      telefone TEXT NOT NULL,
      email TEXT NOT NULL)"""
    );
    print("tabela pacientes criada");
    await db.execute(
      """CREATE TABLE IF NOT EXISTS consultas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      paciente_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      especialidade TEXT NOT NULL,
      doutor TEXT NO NULL,
      observacao TEXT,
      FOREING KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
      )"""
    );
    print("tabela consulta criada");
  }

  Future<int> insertPaciente(Paciente paciente) async{
    final db = await database;
    return await db.insert("pacientes", paciente.toMap());
  }

  Future<List<Paciente>> getPacientes() async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query("pacientes");
    return maps.map((e)=>Paciente.formMap(e)).toList();
  }

Future<Paciente?> getPacientebyId(int id) async{
  final db = await database;
  final List<Map<String, dynamic>> maps =
  await db.query("pacientes", where: "id=?", whereArgs: [id]);
  if(maps.isNotEmpty){
    return Paciente.formMap(maps.first);
  }else{
    return null;
  }
}

Future<int> deletePaciente(int id) async{
  final db = await database;
  return await db.delete("pacientes", wherw: "id=?", whereArgs: [id]);
}

Future<int> insertConsulta(Consulta consulta) async{
  final db = await database;
  return await db.insert("cosultas", consulta.toMap());
}

Future<List<Consulta>> getConsultaByPacienteId(int pecienteId) async{
  final db = await database;
  final List<Map<String,dynamic>> maps = await db.query(
    "consultas",
    where: "pecientes_id = ?",
    whereArgs: [pacienteId],
    orderBy: "data_hora ASC"
  );
  return maps.map((e)=>Consulta.formMap(e)).toList();
}

Future<int> deleteConsulta(int id) async{
  final db = await database;
  return await db.delete("consultas", where: "id=?", whereArgs: [id]);
}


}