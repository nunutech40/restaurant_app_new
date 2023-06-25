import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_new/common/navigation.dart';
import 'package:restaurant_app_new/provider/bookmarks_provider.dart';
import 'package:restaurant_app_new/provider/preferences_provider.dart';
import 'package:restaurant_app_new/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_new/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_new/routes/routes.dart';
import 'package:restaurant_app_new/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/preferences/preferences_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              RestaurantSearchProvider(apiService: ApiService(), text: ''),
        ),
        ChangeNotifierProvider(
          create: (_) => BookMarkProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BookMarkProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            navigatorKey: navigatorKey,
            initialRoute: HomePage.routeName,
            routes: Routes.getRoutes());
      }),
    );
  }
}