class RestaurantDetailResponse {
  final bool error;
  final String message;
  final RestaurantDetail? restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      restaurant:
          RestaurantDetail.fromJson(json['restaurant'] as Map<String, dynamic>),
    );
  }
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoriesList = json['categories'] as List<dynamic>;
    final List<Category> categories = categoriesList
        .map((dynamic categoryJson) => Category.fromJson(categoryJson))
        .toList();

    final Map<String, dynamic> menusJson =
        json['menus'] as Map<String, dynamic>;
    final Menus menus = Menus.fromJson(menusJson);

    final List<dynamic> reviewsList = json['customerReviews'] as List<dynamic>;
    final List<CustomerReview> customerReviews = reviewsList
        .map((dynamic reviewJson) => CustomerReview.fromJson(reviewJson))
        .toList();

    return RestaurantDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pictureId: json['pictureId'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      categories: categories,
      menus: menus,
      rating: (json['rating'] as num).toDouble(),
      customerReviews: customerReviews,
    );
  }
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
    );
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    final List<dynamic> foodsList = json['foods'] as List<dynamic>;
    final List<Food> foods =
        foodsList.map((dynamic foodJson) => Food.fromJson(foodJson)).toList();

    final List<dynamic> drinksList = json['drinks'] as List<dynamic>;
    final List<Drink> drinks = drinksList
        .map((dynamic drinkJson) => Drink.fromJson(drinkJson))
        .toList();

    return Menus(
      foods: foods,
      drinks: drinks,
    );
  }
}

class Food {
  final String name;

  Food({
    required this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] as String,
    );
  }
}

class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'] as String,
    );
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] as String,
      review: json['review'] as String,
      date: json['date'] as String,
    );
  }
}
