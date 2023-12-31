import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurant_app_new/data/db/database_helper.dart';
import 'package:restaurant_app_new/data/model/restaurant_list.dart';

import '../utils/result_state.dart';

class BookMarkProvider extends ChangeNotifier {
  late final DatabaseHelper databaseHelper;

  BookMarkProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  ResultState _state = ResultState.loading; // Initialization done here
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    try {
      final isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        _state = ResultState.error;
        _message =
            'No internet connection. Please check your internet connection and try again.';
        notifyListeners();
        return;
      }

      _bookmarks = await databaseHelper.getBookmarks();

      if (_bookmarks.isEmpty) {
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

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkedRestaurant = await databaseHelper.getBookmarkById(id);
    return bookmarkedRestaurant.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
