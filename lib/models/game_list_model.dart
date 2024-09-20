class GameListResponseModel {
  final List<Result> results;

  GameListResponseModel({required this.results});

  factory GameListResponseModel.fromJson(Map<String, dynamic> json) {
    return GameListResponseModel(
      results: (json['results'] as List).map((i) => Result.fromJson(i)).toList(),
    );
  }
}

class Result {
  final int id;
  final String name;
  final DateTime released;
  final String backgroundImage;
  final double rating;
  final int ratingTop;
  final List<Rating> ratings;
  final int ratingsCount;
  final List<PlatformElement> platforms;
  final List<Genre> genres;
  final List<Store> stores;

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
      name: json['name'] as String? ?? '',
      released: DateTime.tryParse(json['released'] ?? '') ?? DateTime.now(),
      backgroundImage: json['background_image'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingTop: json['rating_top'] ?? 0,
      ratings: (json['ratings'] as List?)?.map((i) => Rating.fromJson(i)).toList() ?? [],
      ratingsCount: json['ratings_count'] ?? 0,
      platforms: (json['platforms'] as List?)?.map((i) => PlatformElement.fromJson(i)).toList() ?? [],
      genres: (json['genres'] as List?)?.map((i) => Genre.fromJson(i)).toList() ?? [],
      stores: (json['stores'] as List?)?.map((i) => Store.fromJson(i)).toList() ?? [],
    );
  }
}

class Rating {
  final int id;
  final String title;
  final int count;
  final double percent;

  Rating({
    required this.id,
    required this.title,
    required this.count,
    required this.percent,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      title: json['title'],
      count: json['count'],
      percent: (json['percent'] as num).toDouble(),
    );
  }
}

class PlatformElement {
  final Platform platform;
  final String releasedAt;
  final RequirementsEn requirementsEn;

  PlatformElement({
    required this.platform,
    required this.releasedAt,
    required this.requirementsEn,
  });

  factory PlatformElement.fromJson(Map<String, dynamic> json) {
    return PlatformElement(
      platform: Platform.fromJson(json['platform']),
      releasedAt: json['released_at'] ?? '',
      requirementsEn: RequirementsEn.fromJson(json['requirements_en'] ?? {}),
    );
  }
}

class Platform {
  final int id;
  final String name;
  final String slug;
  final dynamic image;
  final dynamic yearEnd;
  final dynamic yearStart;
  final int gamesCount;
  final String imageBackground;

  Platform({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.yearEnd,
    required this.yearStart,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      yearEnd: json['year_end'],
      yearStart: json['year_start'],
      gamesCount: json['games_count'],
      imageBackground: json['image_background'] ?? '',
    );
  }
}

class RequirementsEn {
  final String minimum;
  final String recommended;

  RequirementsEn({
    required this.minimum,
    required this.recommended,
  });

  factory RequirementsEn.fromJson(Map<String, dynamic> json) {
    return RequirementsEn(
      minimum: json['minimum'] ?? '',
      recommended: json['recommended'] ?? '',
    );
  }
}

class Store {
  final int id;
  final StoreDetails store;

  Store({
    required this.id,
    required this.store,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      store: StoreDetails.fromJson(json['store']),
    );
  }
}

class StoreDetails {
  final int id;
  final String name;
  final String slug;

  StoreDetails({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) {
    return StoreDetails(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Genre {
  final int id;
  final String name;
  final String slug;
  final String gamesCount;
  final String imageBackground;

  Genre({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      gamesCount: json['games_count'].toString(),
      imageBackground: json['image_background'] ?? '',
    );
  }
}
