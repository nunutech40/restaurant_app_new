import 'package:flutter/material.dart';

import '../../data/model/restaurant_list.dart';
import '../../ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getImage = "https://restaurant-api.dicoding.dev/images/medium/" +
        restaurant.pictureId;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: {
            'restaurant': restaurant,
            'id': restaurant.id,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Hero(
                tag: getImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    getImage,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, _) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        restaurant.city,
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '${restaurant.rating}',
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
