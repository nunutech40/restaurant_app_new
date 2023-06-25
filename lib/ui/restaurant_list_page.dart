import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_new/ui/restaurant_search_page.dart';

import '../provider/restaurant_list_provider.dart';
import '../utils/result_state.dart';
import '../widgets/widgets/card_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildRestaurantList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 150.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Restaurant',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RestaurantSearchPage.routeName);
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Recommendation restaurant for you!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.state == ResultState.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
              childCount: state.result.restaurants.length,
            ),
          );
        } else if (state.state == ResultState.noData) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(''),
              ),
            ),
          );
        }
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
