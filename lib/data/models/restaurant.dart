class RestaurantList {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)),
      ),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
    );
  }
}

class RestaurantDetail {
  final bool error;
  final String message;
  final RestaurantDetailItem restaurant;

  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      error: json['error'],
      message: json['message'],
      restaurant: RestaurantDetailItem.fromJson(json['restaurant']),
    );
  }
}

class RestaurantDetailItem {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetailItem({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetailItem.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: List<Category>.from(
        json['categories'].map((x) => Category.fromJson(x)),
      ),
      menus: Menus.fromJson(json['menus']),
      rating: json['rating'].toDouble(),
      customerReviews: List<CustomerReview>.from(
        json['customerReviews'].map((x) => CustomerReview.fromJson(x)),
      ),
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name']);
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Food>.from(json['foods'].map((x) => Food.fromJson(x))),
      drinks: List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x))),
    );
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name']);
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
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
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}

class SearchRestaurant {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) {
    return SearchRestaurant(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((x) => Restaurant.fromJson(x)),
      ),
    );
  }
}

class ReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  ReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      error: json['error'],
      message: json['message'],
      customerReviews: List<CustomerReview>.from(
        json['customerReviews'].map((x) => CustomerReview.fromJson(x)),
      ),
    );
  }
}
