//classe de modelagem de dados para Movie

class FavoriteMovie {
  //atributos
  final int id; //id fo tmdb
  final String title; //título do filme no tmdb
  final String posterPath; //caminho do poster no tmdb
  double rating;

  //construtor
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0,
  });

  //métodos de conversã de obj <=> Json

  //toMap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  //fromMap
  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble());
  }
}
