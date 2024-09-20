class SearchGameResponseModel {
  List<Result> results;

  SearchGameResponseModel({required this.results});

  factory SearchGameResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchGameResponseModel(
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
  List<Platform> platforms;
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
      platforms: List<Platform>.from(json['platforms']?.map((x) => Platform.fromJson(x)) ?? []),
      genres: List<Genre>.from(json['genres']?.map((x) => Genre.fromJson(x)) ?? []),
      stores: List<Store>.from(json['stores']?.map((x) => Store.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'platforms': List<dynamic>.from(platforms.map((x) => x.toJson())),
    'stores': List<dynamic>.from(stores.map((x) => x.toJson())),
    'released': released.toIso8601String(),
    'background_image': backgroundImage,
    'rating': rating,
    'rating_top': ratingTop,
    'ratings': List<dynamic>.from(ratings.map((x) => x.toJson())),
    'ratings_count': ratingsCount,
  };
}

class Platform {
  Genre platform;

  Platform({required this.platform});

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      platform: Genre.fromJson(json['platform']),
    );
  }

  Map<String, dynamic> toJson() => {
    'platform': platform.toJson(),
  };
}

class Store {
  Genre store;

  Store({required this.store});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      store: Genre.fromJson(json['store']),
    );
  }

  Map<String, dynamic> toJson() => {
    'store': store.toJson(),
  };
}

class Genre {
  int id;
  String name;
  String slug;

  Genre({required this.id, required this.name, required this.slug});

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

class Rating {
  int id;
  Title title;
  int count;
  double percent;

  Rating({required this.id, required this.title, required this.count, required this.percent});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      title: TitleExtension.fromString(json['title'] ?? ''),
      count: json['count'] ?? 0,
      percent: (json['percent'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title.index,
    'count': count,
    'percent': percent,
  };
}

enum Title {
  EXCEPTIONAL,
  MEH,
  RECOMMENDED,
  SKIP,
}

extension TitleExtension on Title {
  static Title fromString(String value) {
    switch (value.toLowerCase()) {
      case 'exceptional':
        return Title.EXCEPTIONAL;
      case 'meh':
        return Title.MEH;
      case 'recommended':
        return Title.RECOMMENDED;
      case 'skip':
        return Title.SKIP;
      default:
        return Title.MEH;
    }
  }
}
