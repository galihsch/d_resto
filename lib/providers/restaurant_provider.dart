import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/api/api_state.dart';
import '../data/models/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService});

  ApiState<RestaurantList> _restaurantListState = const ApiLoadingState();
  ApiState<RestaurantList> get restaurantListState => _restaurantListState;

  ApiState<RestaurantDetail> _restaurantDetailState = const ApiLoadingState();
  ApiState<RestaurantDetail> get restaurantDetailState =>
      _restaurantDetailState;

  ApiState<SearchRestaurant> _searchState = const ApiLoadingState();
  ApiState<SearchRestaurant> get searchState => _searchState;

  Future<void> fetchAllRestaurants() async {
    try {
      _restaurantListState = const ApiLoadingState();
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      _restaurantListState = ApiLoadedState(restaurantList);
      notifyListeners();
    } catch (e) {
      _restaurantListState = ApiErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _restaurantDetailState = const ApiLoadingState();
      notifyListeners();

      final restaurantDetail = await apiService.getRestaurantDetail(id);
      _restaurantDetailState = ApiLoadedState(restaurantDetail);
      notifyListeners();
    } catch (e) {
      _restaurantDetailState = ApiErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      _searchState = ApiLoadedState(
        SearchRestaurant(error: false, founded: 0, restaurants: []),
      );
      notifyListeners();
      return;
    }

    try {
      _searchState = const ApiLoadingState();
      notifyListeners();

      final searchResult = await apiService.searchRestaurant(query);
      _searchState = ApiLoadedState(searchResult);
      notifyListeners();
    } catch (e) {
      _searchState = ApiErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      await apiService.addReview(id: id, name: name, review: review);
      // Refresh restaurant detail to show the new review
      await fetchRestaurantDetail(id);
    } catch (e) {
      // Handle error if needed
    }
  }
}
