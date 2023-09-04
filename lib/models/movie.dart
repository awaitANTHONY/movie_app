class Movie {
  int? id;
  String? title;
  String? image;
  String? postType;
  String? description;
  String? excerpt;
  String? shareUrl;
  bool? isCommentOpen;
  bool? isLiked;
  bool? isWatchlist;
  String? avgRating;
  String? publishDate;
  String? publishDateGmt;
  String? embedContent;
  String? movieChoice;
  String? movieFile;
  String? urlLink;
  List<Tag>? tag;
  List<Tag>? genre;
  List<Tag>? visibility;
  String? runTime;
  String? censorRating;
  String? releaseDate;
  int? views;
  String? logo;
  String? cast;
  List<Casts>? casts;
  String? crew;
  List<Crews>? crews;
  int? noOfComments;
  String? trailerLink;
  double? imdbRating;
  bool? userHasMembership;
  String? attachment;

  Movie(
      {this.id,
      this.title,
      this.image,
      this.postType,
      this.description,
      this.excerpt,
      this.shareUrl,
      this.isCommentOpen,
      this.isLiked,
      this.isWatchlist,
      this.avgRating,
      this.publishDate,
      this.publishDateGmt,
      this.embedContent,
      this.movieChoice,
      this.movieFile,
      this.urlLink,
      this.tag,
      this.genre,
      this.visibility,
      this.runTime,
      this.censorRating,
      this.releaseDate,
      this.views,
      this.logo,
      this.cast,
      this.casts,
      this.crew,
      this.crews,
      this.noOfComments,
      this.trailerLink,
      this.imdbRating,
      this.userHasMembership,
      this.attachment});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    postType = json['post_type'];
    description = json['description'];
    excerpt = json['excerpt'];
    shareUrl = json['share_url'];
    isCommentOpen = json['is_comment_open'];
    isLiked = json['is_liked'];
    isWatchlist = json['is_watchlist'];
    avgRating = json['avg_rating'];
    publishDate = json['publish_date'];
    publishDateGmt = json['publish_date_gmt'];
    embedContent = json['embed_content'];
    movieChoice = json['movie_choice'];
    movieFile = json['movie_file'];
    urlLink = json['url_link'];
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag!.add(Tag.fromJson(v));
      });
    }
    if (json['genre'] != null) {
      genre = <Tag>[];
      json['genre'].forEach((v) {
        genre!.add(Tag.fromJson(v));
      });
    }
    if (json['visibility'] != null) {
      visibility = <Tag>[];
      json['visibility'].forEach((v) {
        visibility!.add(Tag.fromJson(v));
      });
    }
    runTime = json['run_time'];
    censorRating = json['censor_rating'];
    releaseDate = json['release_date'];
    views = json['views'];
    logo = json['logo'];
    cast = json['cast'];
    if (json['casts'] != null) {
      casts = <Casts>[];
      json['casts'].forEach((v) {
        casts!.add(Casts.fromJson(v));
      });
    }
    crew = json['crew'];
    if (json['crews'] != null) {
      crews = <Crews>[];
      json['crews'].forEach((v) {
        crews!.add(Crews.fromJson(v));
      });
    }
    noOfComments = json['no_of_comments'];
    trailerLink = json['trailer_link'];
    imdbRating = json['imdb_rating'];
    userHasMembership = json['user_has_membership'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['post_type'] = postType;
    data['description'] = description;
    data['excerpt'] = excerpt;
    data['share_url'] = shareUrl;
    data['is_comment_open'] = isCommentOpen;
    data['is_liked'] = isLiked;
    data['is_watchlist'] = isWatchlist;
    data['avg_rating'] = avgRating;
    data['publish_date'] = publishDate;
    data['publish_date_gmt'] = publishDateGmt;
    data['embed_content'] = embedContent;
    data['movie_choice'] = movieChoice;
    data['movie_file'] = movieFile;
    data['url_link'] = urlLink;
    if (tag != null) {
      data['tag'] = tag!.map((v) => v.toJson()).toList();
    }
    if (genre != null) {
      data['genre'] = genre!.map((v) => v.toJson()).toList();
    }
    if (visibility != null) {
      data['visibility'] = visibility!.map((v) => v.toJson()).toList();
    }
    data['run_time'] = runTime;
    data['censor_rating'] = censorRating;
    data['release_date'] = releaseDate;
    data['views'] = views;
    data['logo'] = logo;
    data['cast'] = cast;
    if (casts != null) {
      data['casts'] = casts!.map((v) => v.toJson()).toList();
    }
    data['crew'] = crew;
    if (crews != null) {
      data['crews'] = crews!.map((v) => v.toJson()).toList();
    }
    data['no_of_comments'] = noOfComments;
    data['trailer_link'] = trailerLink;
    data['imdb_rating'] = imdbRating;
    data['user_has_membership'] = userHasMembership;
    data['attachment'] = attachment;
    return data;
  }
}

class Tag {
  int? id;
  String? name;
  String? slug;

  Tag({this.id, this.name, this.slug});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Casts {
  String? id;
  String? character;
  int? position;
  String? image;
  String? name;

  Casts({this.id, this.character, this.position, this.image, this.name});

  Casts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    character = json['character'];
    position = json['position'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['character'] = character;
    data['position'] = position;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}

class Crews {
  String? id;
  String? category;
  String? job;
  int? position;
  String? image;
  String? name;

  Crews(
      {this.id, this.category, this.job, this.position, this.image, this.name});

  Crews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    job = json['job'];
    position = json['position'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['job'] = job;
    data['position'] = position;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}
