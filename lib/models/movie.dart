class Movie {
  int? id;
  String? date;
  String? dateGmt;
  String? modified;
  String? modifiedGmt;
  Title? title;
  Content? content;
  Content? excerpt;
  int? author;
  int? featuredMedia;
  String? commentStatus;
  String? pingStatus;
  bool? sticky;
  String? template;
  String? format;
  List<int>? categories;
  List<int>? tags;
  Embedded? eEmbedded;

  Movie(
      {this.id,
      this.date,
      this.dateGmt,
      this.modified,
      this.modifiedGmt,
      this.title,
      this.content,
      this.excerpt,
      this.author,
      this.featuredMedia,
      this.commentStatus,
      this.pingStatus,
      this.sticky,
      this.template,
      this.format,
      this.categories,
      this.tags,
      this.eEmbedded});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    excerpt =
        json['excerpt'] != null ? Content.fromJson(json['excerpt']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    sticky = json['sticky'];
    template = json['template'];
    format = json['format'];
    categories = json['categories'].cast<int>();
    tags = json['tags'].cast<int>();
    eEmbedded =
        json['_embedded'] != null ? Embedded.fromJson(json['_embedded']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['date_gmt'] = dateGmt;
    data['modified'] = modified;
    data['modified_gmt'] = modifiedGmt;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (excerpt != null) {
      data['excerpt'] = excerpt!.toJson();
    }
    data['author'] = author;
    data['featured_media'] = featuredMedia;
    data['comment_status'] = commentStatus;
    data['ping_status'] = pingStatus;
    data['sticky'] = sticky;
    data['template'] = template;
    data['format'] = format;
    data['categories'] = categories;
    data['tags'] = tags;
    if (eEmbedded != null) {
      data['_embedded'] = eEmbedded!.toJson();
    }
    return data;
  }
}

class Title {
  String? rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    data['protected'] = protected;
    return data;
  }
}

class Embedded {
  List<WpFeaturedmedia>? wpFeaturedmedia;

  Embedded({this.wpFeaturedmedia});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['wp:featuredmedia'] != null) {
      wpFeaturedmedia = <WpFeaturedmedia>[];
      json['wp:featuredmedia'].forEach((v) {
        wpFeaturedmedia!.add(WpFeaturedmedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wpFeaturedmedia != null) {
      data['wp:featuredmedia'] =
          wpFeaturedmedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WpFeaturedmedia {
  String? altText;
  String? mediaType;
  String? mimeType;
  MediaDetails? mediaDetails;
  String? sourceUrl;

  WpFeaturedmedia(
      {this.altText,
      this.mediaType,
      this.mimeType,
      this.mediaDetails,
      this.sourceUrl});

  WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
    altText = json['alt_text'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    mediaDetails = json['media_details'] != null
        ? MediaDetails.fromJson(json['media_details'])
        : null;
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alt_text'] = altText;
    data['media_type'] = mediaType;
    data['mime_type'] = mimeType;
    if (mediaDetails != null) {
      data['media_details'] = mediaDetails!.toJson();
    }
    data['source_url'] = sourceUrl;
    return data;
  }
}

class MediaDetails {
  int? width;
  int? height;
  String? file;
  int? filesize;
  Sizes? sizes;

  MediaDetails({this.width, this.height, this.file, this.filesize, this.sizes});

  MediaDetails.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    file = json['file'];
    filesize = json['filesize'];
    sizes = json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['file'] = file;
    data['filesize'] = filesize;
    if (sizes != null) {
      data['sizes'] = sizes!.toJson();
    }
    return data;
  }
}

class Sizes {
  Medium? medium;
  Medium? large;

  Sizes({this.medium, this.large});

  Sizes.fromJson(Map<String, dynamic> json) {
    medium = json['medium'] != null ? Medium.fromJson(json['medium']) : null;
    large = json['large'] != null ? Medium.fromJson(json['large']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    if (large != null) {
      data['large'] = large!.toJson();
    }
    return data;
  }
}

class Medium {
  String? file;
  String? mimeType;
  String? sourceUrl;

  Medium({this.file, this.mimeType, this.sourceUrl});

  Medium.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['mime_type'] = mimeType;
    data['source_url'] = sourceUrl;
    return data;
  }
}
