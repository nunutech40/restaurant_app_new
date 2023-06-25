class RestaurantResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> restaurantList = json['restaurants'] as List<dynamic>;
    final List<Restaurant> restaurants = restaurantList
        .map((dynamic restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestaurantResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      count: json['count'] as int,
      restaurants: restaurants,
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        pictureId: json['pictureId'] as String,
        city: json['city'] as String,
        rating: json['rating'] is String
            ? double.parse(json['rating'])
            : json['rating'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };
}
