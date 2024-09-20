class DetailGameResponseModel {
  int id;
  String name;
  String nameOriginal;
  String description;
  DateTime released;
  String backgroundImage;
  double rating;
  int ratingTop;
  List<Rating> ratings;
  int ratingsCount;
  List<PlatformElement> platforms;
  List<Store> stores;
  List<Developer> developers;
  List<Developer> genres;

  DetailGameResponseModel({
    required this.id,
    required this.name,
    required this.nameOriginal,
    required this.description,
    required this.released,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.ratings,
    required this.ratingsCount,
    required this.platforms,
    required this.stores,
    required this.developers,
    required this.genres,
  });

  factory DetailGameResponseModel.fromJson(Map<String, dynamic> json) {
    return DetailGameResponseModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameOriginal: json['name_original'] ?? '',
      description: json['description'] ?? '',
      released: DateTime.tryParse(json['released'] ?? '') ?? DateTime.now(),
      backgroundImage: json['background_image'] ?? '',
      rating: (json['rating'] ?? 0.0) as double,
      ratingTop: json['rating_top'] ?? 0,
      ratings: (json['ratings'] as List?)
          ?.map((item) => Rating.fromJson(item))
          .toList() ??
          [],
      ratingsCount: json['ratings_count'] ?? 0,
      platforms: (json['platforms'] as List?)
          ?.map((item) => PlatformElement.fromJson(item))
          .toList() ??
          [],
      stores: (json['stores'] as List?)
          ?.map((item) => Store.fromJson(item))
          .toList() ??
          [],
      developers: (json['developers'] as List?)
          ?.map((item) => Developer.fromJson(item))
          .toList() ??
          [],
      genres: (json['genres'] as List?)
          ?.map((item) => Developer.fromJson(item))
          .toList() ??
          [],
    );
  }
}

class Developer {
  int id;
  String name;
  int gamesCount;
  String imageBackground;

  Developer({
    required this.id,
    required this.name,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      gamesCount: json['games_count'] ?? 0,
      imageBackground: json['image_background'] ?? '',
    );
  }
}

class PlatformElement {
  PlatformPlatform platform;
  DateTime releasedAt;
  Requirements requirements;

  PlatformElement({
    required this.platform,
    required this.releasedAt,
    required this.requirements,
  });

  factory PlatformElement.fromJson(Map<String, dynamic> json) {
    return PlatformElement(
      platform: PlatformPlatform.fromJson(json['platform']),
      releasedAt: DateTime.tryParse(json['released_at'] ?? '') ?? DateTime.now(),
      requirements: Requirements.fromJson(json['requirements'] ?? {}),
    );
  }
}

class PlatformPlatform {
  int id;
  String name;
  String slug;
  dynamic image;
  dynamic yearEnd;
  dynamic yearStart;
  int gamesCount;
  String imageBackground;

  PlatformPlatform({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.yearEnd,
    required this.yearStart,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory PlatformPlatform.fromJson(Map<String, dynamic> json) {
    return PlatformPlatform(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      yearEnd: json['year_end'] ?? '',
      yearStart: json['year_start'] ?? '',
      gamesCount: json['games_count'] ?? 0,
      imageBackground: json['image_background'] ?? '',
    );
  }
}

class Requirements {
  String minimum;

  Requirements({
    required this.minimum,
  });

  factory Requirements.fromJson(Map<String, dynamic> json) {
    return Requirements(
      minimum: json['minimum'] ?? '',
    );
  }
}

class Rating {
  int id;
  String title;
  int count;
  double percent;

  Rating({
    required this.id,
    required this.title,
    required this.count,
    required this.percent,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      count: json['count'] ?? 0,
      percent: json['percent'] ?? 0.0,
    );
  }
}

class Store {
  int id;
  String url;
  Developer store;

  Store({
    required this.id,
    required this.url,
    required this.store,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      store: Developer.fromJson(json['store']),
    );
  }
}
