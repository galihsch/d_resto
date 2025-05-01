import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../data/api/api_state.dart';
import '../data/models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_detail_screen.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({super.key});

  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isInitialState = true;

  @override
  void initState() {
    super.initState();
    // Setel state ke initial true
    _isInitialState = true;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Cari Restoran'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Cari nama, kategori, atau menu...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    // Tidak perlu memicu searchRestaurants lagi
                    setState(() {
                      _isInitialState = true;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                if (_isInitialState) {
                  setState(() {
                    _isInitialState = false;
                  });
                }
                Provider.of<RestaurantProvider>(
                  context,
                  listen: false,
                ).searchRestaurants(value);
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF121212) : Colors.white,
              ),
              child:
                  _isInitialState
                      ? _buildEmptySearchState(
                        animation: 'assets/animations/search.json',
                        title: 'Ketik untuk mencari restoran',
                        subtitle: 'Cari berdasarkan nama, kategori, atau menu',
                      )
                      : Consumer<RestaurantProvider>(
                        builder: (context, provider, _) {
                          final state = provider.searchState;
                          return switch (state) {
                            ApiLoadingState() => const LoadingIndicator(
                              message: 'Mencari restoran...',
                            ),
                            ApiLoadedState<SearchRestaurant>() =>
                              _buildSearchResults(
                                state.data.restaurants,
                                state.data.founded,
                              ),
                            ApiErrorState() => ErrorIndicator(
                              message: state.message,
                            ),
                          };
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Restaurant> restaurants, int count) {
    if (_searchController.text.isEmpty) {
      return _buildEmptySearchState(
        animation: 'assets/animations/search.json',
        title: 'Ketik untuk mencari restoran',
        subtitle: 'Cari berdasarkan nama, kategori, atau menu',
      );
    }

    if (count == 0) {
      return _buildEmptySearchState(
        animation: 'assets/animations/empty_box.json',
        title: 'Restoran tidak ditemukan',
        subtitle: 'Coba gunakan kata kunci lain',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return RestaurantCard(
          restaurant: restaurant,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(id: restaurant.id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptySearchState({
    required String animation,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: 180, height: 180, fit: BoxFit.contain),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
