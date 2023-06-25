import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/restauran_detail_provider.dart';
import '../ui/home_page.dart';
import '../ui/restaurant_detail_page.dart';
import '../ui/restaurant_search_page.dart';

class Routes {
  static const home = HomePage.routeName;
  static const restaurantDetail = RestaurantDetailPage.routeName;
  static const restaurantSearch = RestaurantSearchPage.routeName;
  
  static Map<String, WidgetBuilder> getRoutes() => {
    home: (context) => const HomePage(),
    restaurantDetail: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is Map<String, dynamic>) {
        final id = arguments['id'] as String;
        return ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) => RestaurantDetailProvider(
            apiService: ApiService(), // Provide your API service instance here
            id: id,
          ),
          child: RestaurantDetailPage(id: id),
        );
      }
      throw Exception('Invalid arguments provided');
    },
    restaurantSearch: (context) => const RestaurantSearchPage()
  };
}
