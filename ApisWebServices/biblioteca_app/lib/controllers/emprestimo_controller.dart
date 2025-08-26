import '../models/emprestimo_model.dart';
import '../services/api_service.dart';

class EmprestimoController {

  //métodos

  //GET - All
  Future<List<EmprestimoModel>> fetchAll() async{
    final list = await ApiService.getList("emprestimo?_sort=idUsuario");//ordenando pelo nome A->Z
    //retorna a Lista de Usuários (Json) Convertida para Usuario Model(DART)
    return list.map<EmprestimoModel>((item)=>EmprestimoModel.fromJson(item)).toList(); 
  }

  //GET - One
  Future<EmprestimoModel> fetchOne(String id) async{
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return EmprestimoModel.fromJson(emprestimo);
  }

  //POST
  Future<EmprestimoModel> create(EmprestimoModel e) async{
    final created = await ApiService.post("emprestimos", e.toJson());
    //adicionar o usuário e retorna o usuario adicionado
    return EmprestimoModel.fromJson(created);
  }

  //PUT
  Future<EmprestimoModel> update(EmprestimoModel e) async{
    final updated = await ApiService.put("emprestimos", e.toJson(), e.id!);
    //retorna o usuário atualizado
    return EmprestimoModel.fromJson(updated);
  }

  //DELETE
  Future<void> delete(String id) async{
    await ApiService.delete("emprestimo", id);
    //não tem retorno
  }
}