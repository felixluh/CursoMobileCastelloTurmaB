class Nota{
  //atributos = colunas BD
  final int? id;
  final String titulo;
  final String conteudo;

  //construtor
  Nota({this.id, required this.titulo, required this.conteudo});

  //metodos

  //conversão para Objeto <=> BD

  //toMap Objeto => Bd
  Map<String,dynamic> toMap(){
    return{
      "id":id, // o id pode ser nulo ao criar
    "titulo": titulo,
    "conteudo":conteudo
    };
  }

  //fromMap BD => objeto
factory Nota.fromMap(Map<String,dynamic>map){
  return Nota(
    id: map["id"] as int, //conevrte para int(cast)
    titulo: map["titulo"] as String,
    conteudo: map["conteudo"] as String);
}


}