import 'dart:convert';

class MovieFirebaseModel {
  MovieFirebaseModel({
    this.acquisitiondate,
    this.category,
    this.format,
    this.place,
    this.price,
    this.title,
    this.backdroppath,
    this.posterpath,
    this.voteaverage,
    this.originaltitle,
    this.overview,
    this.id,
    this.heroid,
  });
  String? acquisitiondate;
  String? category;
  String? format;
  String? place;
  String? price;
  String? title;
  String? voteaverage;
  String? posterpath;
  String? backdroppath;
  int? id;
  String? heroid;
  String? originaltitle;
  String? overview;

  get fullPosterImg {
    if (posterpath != null) return 'https://image.tmdb.org/t/p/w500$posterpath';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullBackdropPath {
    if (backdroppath != null) return 'https://image.tmdb.org/t/p/w500$backdroppath';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory MovieFirebaseModel.fromJson(Map<String, dynamic> json) => MovieFirebaseModel(
        acquisitiondate: json["acquisitiondate"],
        category: json["category"],
        format: json["format"],
        place: json["place"],
        price: json["price"],
        title: json["title"],
        voteaverage: json["voteaverage"],
        posterpath: json["posterpath"],
        backdroppath: json["backdroppath"],
        id: json["id"],
        heroid: json["heroid"],
        originaltitle: json["originaltitle"],
        overview: json["overview"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "acquisitiondate": acquisitiondate,
        "category": category,
        "format": format,
        "place": place,
        "price": price,
        "title": title,
        "voteaverage": voteaverage,
        "posterpath": posterpath,
        "backdroppath": backdroppath,
        "id": id,
        "heroid": heroid,
        "originaltitle": originaltitle,
        "overview": overview,
      };
}
