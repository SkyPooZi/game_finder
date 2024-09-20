class FavoriteResponseModel {
  int? id;
  String? image;
  String? name;
  String? release;
  String? genre;
  double? rating;
  String? description;
  String? platform;

  FavoriteResponseModel({
    this.id,
    this.image,
    this.name,
    this.genre,
    this.release,
    this.rating,
    this.description,
    this.platform,
  });

  FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
    genre = json["genre"];
    release = json["release"];
    rating = json["rating"]?.toDouble();
    description = json["description"];
    platform = json["platform"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "genre": genre,
      "release": release,
      "rating": rating,
      "description": description,
      "platform": platform,
    };
  }
}
