class EmprestimoModel {
  //atributos
  final String? id;
  final String idUsuario;
  final String idLivro;
  final String dataEmprestimo;
  final String dataDevolucao;
  final String devolvido;

  //construtor
  EmprestimoModel({
    this.id,
    required this.idUsuario,
    required this.idLivro,
    required this.dataEmprestimo,
    required this.dataDevolucao,
    required this.devolvido,
  });

  //métodos
  //toJson
  Map<String, dynamic> toJson() => {
    "id": id,
    "idUsuario": idUsuario,
    "idLivro": idLivro,
    "dataEmprestimo": dataEmprestimo,
    "dataDevolucao": dataDevolucao,
    "devolvido": devolvido,
  };

  //fromJson
  factory EmprestimoModel.fromJson(Map<String, dynamic> json) => EmprestimoModel(
    id: json["id"].toString(),
    idUsuario: json["idUsuario"].toString(),
    idLivro: json["idLivro"].toString(),
    dataEmprestimo: json["dataEmprestimo"].toString(),
    dataDevolucao: json["dataDevolucao"].toString(),
    devolvido: json["devolvido"].toString(),
  );
}
