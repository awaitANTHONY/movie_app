class News {
  bool? status;
  List<NewsData>? data;

  News({this.status, this.data});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NewsData>[];
      json['data'].forEach((v) {
        data!.add(NewsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsData {
  String? title;
  String? link;
  String? date;
  String? description;
  String? image;

  NewsData({this.title, this.link, this.date, this.description, this.image});

  NewsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    date = json['date'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['date'] = date;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
