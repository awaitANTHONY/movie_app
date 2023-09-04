import 'movie.dart';

class Home {
  List<Movie>? banner;
  List<Sliders>? sliders;

  Home({this.banner, this.sliders});

  Home.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = <Movie>[];
      json['banner'].forEach((v) {
        banner!.add(Movie.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String? title;
  bool? viewAll;
  List<Movie>? data;

  Sliders({this.title, this.viewAll, this.data});

  Sliders.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    viewAll = json['view_all'];
    if (json['data'] != null) {
      data = <Movie>[];
      json['data'].forEach((v) {
        data!.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['view_all'] = viewAll;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
