import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app_new/data/api/api_service.dart';
import 'package:restaurant_app_new/data/model/restaurant_detail.dart';
import 'package:restaurant_app_new/data/model/restaurant_list.dart';
import 'package:restaurant_app_new/data/model/restaurant_list_search.dart';

void main() {
  group(
    'Testing Restaurant API',
    () {
      test(
        'for Restaurant List',
        () async {
          final client = MockClient(
            (request) async {
              final response = {
                "error": false,
                "message": "success",
                "count": 20,
                "restaurants": []
              };
              return Response(json.encode(response), 200);
            },
          );

          final apiService = ApiService(client: client);
          expect(await apiService.restauranList(), isA<RestaurantResponse>());
        },
      );

      test(
        'for Restaurant Detail when restaurant id is found',
        () async {
          final client = MockClient(
            (request) async {
              final response = {
                "error": false,
                "message": "success",
                "restaurant": {
                  "id": "",
                  "name": "",
                  "description": "",
                  "city": "",
                  "address": "",
                  "pictureId": "",
                  "categories": [],
                  "menus": {"foods": [], "drinks": []},
                  "rating": 1.0,
                  "customerReviews": []
                }
              };
              return Response(json.encode(response), 200);
            },
          );

          final apiService = ApiService(client: client);
          expect(await apiService.restaurantDetail('Restaurant Id Example'),
              isA<RestaurantDetailResponse>());
        },
      );

      test(
        'for Restaurant Search',
        () async {
          final client = MockClient(
            (request) async {
              final response = {
                "error": false,
                "founded": 1,
                "restaurants": []
              };
              return Response(json.encode(response), 200);
            },
          );

          final apiService = ApiService(client: client);
          expect(await apiService.restaurantSearch('Restaurant Name Example'),
              isA<SearchResponse>());
        },
      );
    },
  );
}
