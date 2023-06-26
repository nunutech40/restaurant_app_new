import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/restaurant_detail.dart';
import '../model/restaurant_list.dart';
import '../model/restaurant_list_search.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _restaurantListEndPoint = '/list';
  static const String _restaurantDetailEndPoint = '/detail';
  static const String _restaurantSearchEndPoint = '/search?q=';

  Uri _buildUrl(String path, [String? queryParameter]) {
    return Uri.parse(_baseUrl + path + (queryParameter ?? ""));
  }

  Future<RestaurantResponse> restauranList() async {
    final response = await _client.get(_buildUrl(_restaurantListEndPoint));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load restaurant list. Status code: ${response.statusCode}');
    }
  }

  Future<RestaurantDetailResponse> restaurantDetail(String id) async {
    final response =
        await _client.get(_buildUrl(_restaurantDetailEndPoint + "/" + id));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load restaurant detail. Status code: ${response.statusCode}');
    }
  }

  Future<SearchResponse> restaurantSearch(String text) async {
    final response =
        await _client.get(_buildUrl(_restaurantSearchEndPoint, text));

    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load restaurant list. Status code: ${response.statusCode}');
    }
  }
}
