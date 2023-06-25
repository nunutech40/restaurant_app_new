import 'package:restaurant_app_new/data/model/restaurant_list.dart';

class SearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> restaurantList = json['restaurants'] as List<dynamic>;
    final List<Restaurant> restaurants = restaurantList
        .map((dynamic restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return SearchResponse(
      error: json['error'] as bool,
      founded: json['founded'] as int,
      restaurants: restaurants,
    );
  }
}
