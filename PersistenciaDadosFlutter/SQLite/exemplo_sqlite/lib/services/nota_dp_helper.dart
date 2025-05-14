import 'package:exemplo_sqlite/models/nota_model.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotaDbHelper {

  Database? _database; //classe de conecção com o bd

  static const DB_NAME = "notas.db";
  static const TABLE_NAME = "notas";
  static const CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, conteudo TEXT NOT NULL)"; 


  //metodos de conexão

Future<Database> get database async{
  if(_database != null){
    return _database!; // se não tiver conexao retirna a mesma ja estabelecida
  }
  _database = await _initDatabase();
  return _database!; //caso não tenha conexão retorna uma nova conexão
}

Future<Database> _initDatabase() async{
  final dbPath = await getDatabasesPath(); // pegar o caminho ao BD
  final path = join(dbPath, DB_NAME); // o BD e o caminho

  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(CREATE_TABLE_SQL);
    },
    version: 1,
    //implementar o upgrade version ()
    );
}

//CRUD (não precisa usar o SQL)
//CREATE
Future<int> insertNota(Nota nota) async{
  final db = await database;
  return db.insert(TABLE_NAME, nota.toMap()); //converte a nota para modelo de DB
}

//READ
Future<List<Nota>> getNotas()async{
  final db = await database;
  final List<Map<String,dynamic>> maps = await db.query(TABLE_NAME);
  return maps.map((e)=> Nota.fromMap(e)).toList();
}

//UPDATE
Future<int> updateNota(Nota nota) async{
  if(nota.id == null){
    throw Exception();
  }
Final db = await database;
  return await db.update(
    TABLE_NAME,
    nota.toMap(),
    where: "id = ?",
    whereArgs: [nota.id]
    );
}

//DELETE BD
Future<int> deleteNota(int id) async{
  final db = await database;
  return await db.delete(
    TABLE_NAME,
    where: "id=?",
    whereArgs: [id]
  );
}

}