import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_new/provider/bookmarks_provider.dart';

import '../utils/result_state.dart';
import '../widgets/widgets/card_restaurant.dart';

class RestaurantBookmarkPage extends StatefulWidget {
  static const String bookmarksTitle = 'Bookmarks';

  const RestaurantBookmarkPage({Key? key}) : super(key: key);

  @override
  _RestaurantBookmarkPageState createState() => _RestaurantBookmarkPageState();
}

class _RestaurantBookmarkPageState extends State<RestaurantBookmarkPage> {
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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Bookmarks Restaurant',
                      style: TextStyle(
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
                'This is Bookmakrs Restaurant You Like It!',
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
  return Consumer<BookMarkProvider>(
    builder: (context, provider, _) {
      if (provider.state == ResultState.loading) {
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      } else if (provider.state == ResultState.hasData) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var restaurant = provider.bookmarks[index];
              return CardRestaurant(restaurant: restaurant);
            },
            childCount: provider.bookmarks.length,
          ),
        );
      } else if (provider.state == ResultState.noData) {
        return SliverFillRemaining(
          child: Center(
            child: Material(
              child: Text(provider.message),
            ),
          ),
        );
      } else if (provider.state == ResultState.error) {
        return SliverFillRemaining(
          child: Center(
            child: Material(
              child: Text(
                provider.message,
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
