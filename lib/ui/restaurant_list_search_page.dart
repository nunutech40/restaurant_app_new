import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_search_provider.dart';
import '../utils/result_state.dart';
import '../widgets/widgets/card_restaurant.dart';

class RestaurantListSearchPage extends StatefulWidget {
  const RestaurantListSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantListSearchPageState createState() =>
      _RestaurantListSearchPageState();
}

class _RestaurantListSearchPageState extends State<RestaurantListSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildSearchField(),
          _buildRestaurantList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onChanged: (value) {
            // Perform search action
            Provider.of<RestaurantSearchProvider>(context, listen: false)
                .searchRestaurant(value);
          },
        ),
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
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Search',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Search Recommendation restaurant for you!',
                  style: const TextStyle(
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
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return SliverFillRemaining(
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
          return SliverFillRemaining(
            child: const Center(
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
