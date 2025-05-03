import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class RestaurantApiService {
  final String baseUrl;

  RestaurantApiService({required this.baseUrl});

  Future<RestaurantList> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list'));
      if (response.statusCode == 200) {
        return RestaurantList.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat daftar restoran: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet');
      }
      rethrow;
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat detail restoran: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet');
      }
      rethrow;
    }
  }

  Future<SearchRestaurant> searchRestaurants(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
      if (response.statusCode == 200) {
        return SearchRestaurant.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal memuat hasil pencarian: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet');
      }
      rethrow;
    }
  }

  Future<ReviewResponse> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/review'),
        headers: {'Content-Type': 'application/json', 'X-Auth-Token': '12345'},
        body: jsonEncode({'id': id, 'name': name, 'review': review}),
      );

      if (response.statusCode == 201) {
        return ReviewResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal mengirim review: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Tidak ada koneksi internet');
      }
      rethrow;
    }
  }
}
