import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/api/api_state.dart';
import '../data/models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/scroll_provider.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_indicator.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_detail_screen.dart';
import 'restaurant_search_screen.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(
        context,
        listen: false,
      ).fetchAllRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
      body: NestedScrollView(
        controller: scrollProvider.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false,
              pinned: true,
              elevation: scrollProvider.isScrolled ? 4 : 0,
              backgroundColor:
                  scrollProvider.isScrolled
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  'D\'Resto',
                  style: TextStyle(
                    color:
                        scrollProvider.isScrolled
                            ? (isDarkMode ? Colors.white : Colors.black87)
                            : Colors.transparent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Color(0xFFFF7043),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.2,
                          child: Icon(
                            Icons.restaurant,
                            size: 200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 50.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Temukan Restoran Terbaik',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Jelajahi berbagai pilihan restoran untuk pengalaman kuliner spesial Anda',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color:
                        scrollProvider.isScrolled
                            ? (isDarkMode ? Colors.white : Colors.black87)
                            : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantSearchScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Provider.of<ThemeProvider>(context).isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color:
                        scrollProvider.isScrolled
                            ? (isDarkMode ? Colors.white : Colors.black87)
                            : Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                ),
              ],
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF121212) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                final state = provider.restaurantListState;

                return switch (state) {
                  ApiLoadingState() => const LoadingIndicator(
                    message: 'Memuat daftar restoran...',
                  ),
                  ApiLoadedState<RestaurantList>() => _buildRestaurantList(
                    state.data.restaurants,
                  ),
                  ApiErrorState() => ErrorIndicator(
                    message: state.message,
                    onRetry: () {
                      provider.fetchAllRestaurants();
                    },
                  ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
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
}
