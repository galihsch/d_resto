import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Get restaurant list
  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  // Get restaurant detail
  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  // Search restaurant
  Future<SearchRestaurant> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  // Add review
  Future<ReviewResponse> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id, 'name': name, 'review': review}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }

  // Get restaurant image URL
  static String getSmallImageUrl(String pictureId) {
    return '$_baseUrl/images/small/$pictureId';
  }

  static String getMediumImageUrl(String pictureId) {
    return '$_baseUrl/images/medium/$pictureId';
  }

  static String getLargeImageUrl(String pictureId) {
    return '$_baseUrl/images/large/$pictureId';
  }
}
