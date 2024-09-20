class PagingResponseModel {
  List<Result> results;

  PagingResponseModel({required this.results});

  factory PagingResponseModel.fromJson(Map<String, dynamic> json) {
    return PagingResponseModel(
      results: List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'results': List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  DateTime released;
  String backgroundImage;
  double rating;
  int ratingTop;
  List<Rating> ratings;
  int ratingsCount;
  List<PlatformElement> platforms;
  List<Genre> genres;
  List<Store> stores;

  Result({
    required this.id,
    required this.name,
    required this.released,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.ratings,
    required this.ratingsCount,
    required this.platforms,
    required this.genres,
    required this.stores,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      released: DateTime.tryParse(json['released'] ?? '') ?? DateTime.now(),
      backgroundImage: json['background_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingTop: json['rating_top'] ?? 0,
      ratings: List<Rating>.from(json['ratings']?.map((x) => Rating.fromJson(x)) ?? []),
      ratingsCount: json['ratings_count'] ?? 0,
      platforms: List<PlatformElement>.from(json['platforms']?.map((x) => PlatformElement.fromJson(x)) ?? []),
      genres: List<Genre>.from(json['genres']?.map((x) => Genre.fromJson(x)) ?? []),
      stores: List<Store>.from(json['stores']?.map((x) => Store.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'released': released.toIso8601String(),
    'background_image': backgroundImage,
    'rating': rating,
    'rating_top': ratingTop,
    'ratings': List<dynamic>.from(ratings.map((x) => x.toJson())),
    'ratings_count': ratingsCount,
    'platforms': List<dynamic>.from(platforms.map((x) => x.toJson())),
    'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
    'stores': List<dynamic>.from(stores.map((x) => x.toJson())),
  };
}

class Rating {
  int id;
  String title;
  double value;
  int count;

  Rating({
    required this.id,
    required this.title,
    required this.value,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'value': value,
    'count': count,
  };
}

class PlatformElement {
  Platform platform;

  PlatformElement({required this.platform});

  factory PlatformElement.fromJson(Map<String, dynamic> json) {
    return PlatformElement(
      platform: Platform.fromJson(json['platform']),
    );
  }

  Map<String, dynamic> toJson() => {
    'platform': platform.toJson(),
  };
}

class Platform {
  int id;
  String name;
  String slug;
  bool? image;
  bool? yearEnd;

  Platform({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.yearEnd,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'],
      yearEnd: json['year_end'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'year_end': yearEnd,
  };
}

class Genre {
  int id;
  String name;
  String slug;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
  };
}

class Store {
  int id;
  String storeId;
  String name;
  String slug;

  Store({
    required this.id,
    required this.storeId,
    required this.name,
    required this.slug,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      storeId: json['store_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'store_id': storeId,
    'name': name,
    'slug': slug,
  };
}
