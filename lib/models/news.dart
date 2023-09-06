class FootballNews {
  List<News>? news;

  FootballNews({this.news});

  FootballNews.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? title;
  String? link;
  String? description;
  String? pubDate;
  String? image;
  String? newsType;

  News(
      {this.title,
      this.link,
      this.description,
      this.pubDate,
      this.image,
      this.newsType});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    description = json['description'];
    pubDate = json['pubDate'];
    image = json['image'];
    newsType = json['news_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['description'] = description;
    data['pubDate'] = pubDate;
    data['image'] = image;
    data['news_type'] = newsType;
    return data;
  }
}
