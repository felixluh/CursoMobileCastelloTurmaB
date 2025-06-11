class Paciente {

final int? id;
final String nome;
final String cpf;
final DateTime dataDeNascimento;
final String telefone;
final String email;

Paciente({
  required this.id,
  required this.nome,
  required this.cpf,
  required this.dataDeNascimento,
  required this.telefone,
  required this.email,
});

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'nome': nome,
    'cpf': cpf,
    'dataDeNascimento': dataDeNascimento.toIso8601String(),
    'telefone': telefone,
    'email': email,
  };
}

factory Paciente.formMap(Map<String, dynamic> map) {
  return Paciente(
    id: map['id'] as int,
    nome: map['nome'] as String,
    cpf: ['cpf'] as String,
    dataDeNascimento: DateTime.parse(map["data_hora"] as String),
    telefone: ['telefone'] as String,
    email: ['email'] as String);
}


String get dataNascimentoLocal {
  final local = DateFormat("dd/MM/yyyy");
  return local.format(dataDeNascimento);
}

}