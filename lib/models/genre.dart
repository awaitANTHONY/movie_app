class Genre {
  int? id;
  String? name;
  String? slug;
  String? genreImage;

  Genre({this.id, this.name, this.slug, this.genreImage});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    genreImage = json['genre_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['genre_image'] = genreImage;
    return data;
  }
}
