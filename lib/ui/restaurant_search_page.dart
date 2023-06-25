import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_new/ui/restaurant_list_search_page.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_search_provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search_page';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestaurantListSearchPage();
  }
}
