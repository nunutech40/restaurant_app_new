import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restauran_detail_provider.dart';
import '../utils/result_state.dart';
import '../widgets/widgets/card_restaurant_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail'),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, restaurantDetailProvider, _) {
          final restaurantDetail = restaurantDetailProvider.result?.restaurant;
          final error = restaurantDetailProvider.error;

          if (restaurantDetailProvider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (error != null) {
            return Center(
              child: Text('Error: $error'),
            );
          } else if (restaurantDetail == null) {
            return const Center(
              child: Text(
                'No data available',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return CardRestaurantDetail(restaurantDetail: restaurantDetail);
          }
        },
      ),
    );
  }
}
