import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/restaurant_detail.dart';
import '../../data/model/restaurant_list.dart';
import '../../provider/bookmarks_provider.dart';

class CardRestaurantDetail extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  const CardRestaurantDetail({Key? key, required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getImage = "https://restaurant-api.dicoding.dev/images/medium/" +
        restaurantDetail.pictureId;

    return Consumer<BookMarkProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isBookmarked(restaurantDetail.id),
            builder: (context, snapshot) {
              var isBookmarked = snapshot.data ?? false;
              return SingleChildScrollView(
                child: Column(children: [
                  Hero(
                    tag: getImage,
                    child: Image.network(getImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    restaurantDetail.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onPressed: () {
                                    var restaurant = Restaurant(
                                        id: restaurantDetail.id,
                                        name: restaurantDetail.name,
                                        description:
                                            restaurantDetail.description,
                                        pictureId: restaurantDetail.pictureId,
                                        city: restaurantDetail.city,
                                        rating: restaurantDetail.rating);

                                    isBookmarked
                                        ? provider.removeBookmark(restaurant.id)
                                        : provider.addBookmark(restaurant);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(
                                children: [
                                  Text('Location ${restaurantDetail.city}',
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(
                                    'Rating ${restaurantDetail.rating}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tentang restaurant ini",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          restaurantDetail.description,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    height: 100, // Adjust the height as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Foods Menu",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetail.menus?.foods.length,
                            itemBuilder: (context, index) {
                              final food = restaurantDetail.menus?.foods[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(
                                  label: Text(food?.name ?? ""),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100, // Adjust the height as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Drinks Menu",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantDetail.menus?.drinks.length,
                            itemBuilder: (context, index) {
                              final drink =
                                  restaurantDetail.menus?.drinks[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(
                                  label: Text(drink?.name ?? ""),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              );
            });
      },
    );
  }
}
