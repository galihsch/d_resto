import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Get restaurant list
  Future<RestaurantList> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));

      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Gagal memuat daftar restoran: Server tidak merespons dengan benar (${response.statusCode})',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception(
          'Tidak ada koneksi internet. Silakan periksa koneksi Anda dan coba lagi.',
        );
      } else if (e is HttpException) {
        throw Exception(
          'Tidak dapat menemukan layanan. Silakan coba lagi nanti.',
        );
      } else if (e is FormatException) {
        throw Exception('Format data tidak valid. Silakan coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu koneksi habis. Silakan coba lagi nanti.');
      }
      rethrow;
    }
  }

  // Get restaurant detail
  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Gagal memuat detail restoran: Server tidak merespons dengan benar (${response.statusCode})',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception(
          'Tidak ada koneksi internet. Silakan periksa koneksi Anda dan coba lagi.',
        );
      } else if (e is HttpException) {
        throw Exception(
          'Tidak dapat menemukan layanan. Silakan coba lagi nanti.',
        );
      } else if (e is FormatException) {
        throw Exception('Format data tidak valid. Silakan coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu koneksi habis. Silakan coba lagi nanti.');
      }
      rethrow;
    }
  }

  // Search restaurant
  Future<SearchRestaurant> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        return SearchRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Gagal mencari restoran: Server tidak merespons dengan benar (${response.statusCode})',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception(
          'Tidak ada koneksi internet. Silakan periksa koneksi Anda dan coba lagi.',
        );
      } else if (e is HttpException) {
        throw Exception(
          'Tidak dapat menemukan layanan. Silakan coba lagi nanti.',
        );
      } else if (e is FormatException) {
        throw Exception('Format data tidak valid. Silakan coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu koneksi habis. Silakan coba lagi nanti.');
      }
      rethrow;
    }
  }

  // Add review
  Future<ReviewResponse> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/review'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id, 'name': name, 'review': review}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReviewResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Gagal menambahkan ulasan: Server tidak merespons dengan benar (${response.statusCode})',
        );
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception(
          'Tidak ada koneksi internet. Silakan periksa koneksi Anda dan coba lagi.',
        );
      } else if (e is HttpException) {
        throw Exception(
          'Tidak dapat menemukan layanan. Silakan coba lagi nanti.',
        );
      } else if (e is FormatException) {
        throw Exception('Format data tidak valid. Silakan coba lagi nanti.');
      } else if (e is TimeoutException) {
        throw Exception('Waktu koneksi habis. Silakan coba lagi nanti.');
      }
      rethrow;
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
