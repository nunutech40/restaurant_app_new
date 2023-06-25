import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _restaurantDetailResult = RestaurantDetailResponse(
      error: true,
      message: '',
      restaurant: null,
    );
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetailResponse _restaurantDetailResult;
  ResultState _state = ResultState.loading;
  String _message = '';
  dynamic _error;

  String get message => _message;

  RestaurantDetailResponse get result => _restaurantDetailResult;

  ResultState get state => _state;

  dynamic get error => _error;

  Future<void> _fetchRestaurantDetail(String id) async {
    try {
      final isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        _state = ResultState.error;
        _message =
            'No internet connection. Please check your internet connection and try again.';
        notifyListeners();
        return;
      }

      final restaurantDetail = await apiService.restaurantDetail(id);
      _restaurantDetailResult = restaurantDetail;

      if (_restaurantDetailResult.restaurant == null) {
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
}
