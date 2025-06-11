class Consulta{
  final int? id;
  final int pacienteId;
  final DateTime dataHora;
  final String especialidade;
  final String doutor;
  final String observacao;

  Consulta({
    this.id,
    required this.pacienteId,
    required this.dataHora,
    required this.especialidade,
    required this.doutor,
    required this.observacao
  });

  Map<String, dynamic> toMap() => {
    "id":id,
    "paciente_id": pacienteId,
    "data_hora": dataHora.toIso8601String(),
    "especialidade": especialidade,
    "doutor": doutor,
    "observacao": observacao
  };

  factory Consulta.formMap(Map<String,dynamic> map) =>
  Consulta(
    id: map["id"] as int,
    pacienteId: map["pacienteId"] as int,
    dataHora: DateTime.parse(map["dataHora"] as String),
    especialidade: map ["especialidade"] as String,
    doutor: map ["doutor"] as String,
    observacao: map["observacao"] as String);

    String get dataHoraLocal {
      final local = DateFormat("dd/mm/yyyy HH:mm");
      return local.format(dataHora);
    }
    
  
}
