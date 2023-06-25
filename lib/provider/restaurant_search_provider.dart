import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurant_list_search.dart';
import '../utils/result_state.dart';


class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String text;

  RestaurantSearchProvider({required this.apiService, required this.text}) {
    _fetchRestaurantSearch(text);
  }

  late SearchResponse _searchRestaurantResult;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  SearchResponse get result => _searchRestaurantResult;

  ResultState get state => _state;

  Future<void> _fetchRestaurantSearch(String text) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        _state = ResultState.error;
        _message =
            'No internet connection. Please check your internet connection and try again.';
        notifyListeners();
        return;
      }

      final restauranSearchtList = await apiService.restaurantSearch(text);
      _searchRestaurantResult = restauranSearchtList;

      if (_searchRestaurantResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'An error occurred while fetching restaurant data: $e';
    } finally {
      notifyListeners();
    }
  }

  void searchRestaurant(String searchText) {
    _fetchRestaurantSearch(searchText);
  }
}
