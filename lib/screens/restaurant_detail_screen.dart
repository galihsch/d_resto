// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import '../data/api/api_service.dart';
import '../data/api/api_state.dart';
import '../data/models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/review_form.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;

  const RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(
        context,
        listen: false,
      ).fetchRestaurantDetail(widget.id);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Membersihkan resources sebelum kembali
        return true;
      },
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, provider, _) {
            final state = provider.restaurantDetailState;

            return switch (state) {
              ApiLoadingState() => const LoadingIndicator(
                message: 'Memuat detail restoran...',
              ),
              ApiLoadedState<RestaurantDetail>() => _buildDetailContent(
                state.data.restaurant,
                provider,
              ),
              ApiErrorState() => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                ),
                body: ErrorIndicator(
                  message: state.message,
                  onRetry: () {
                    provider.fetchRestaurantDetail(widget.id);
                  },
                ),
              ),
            };
          },
        ),
      ),
    );
  }

  Widget _buildDetailContent(
    RestaurantDetailItem restaurant,
    RestaurantProvider provider,
  ) {
    return SafeArea(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(restaurant),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restaurant details
                    _buildRestaurantInfo(restaurant),
                    const Divider(height: 32),

                    // Restaurant description
                    _buildSectionTitle('Deskripsi'),
                    const SizedBox(height: 8),
                    Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),

                    // Restaurant categories
                    _buildSectionTitle('Kategori'),
                    const SizedBox(height: 12),
                    _buildCategoriesList(restaurant.categories),
                    const SizedBox(height: 24),

                    // Restaurant menus
                    _buildSectionTitle('Menu'),
                    const SizedBox(height: 12),
                    _buildMenus(restaurant.menus),
                    const SizedBox(height: 24),

                    // Customer reviews
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_buildSectionTitle('Ulasan')],
                    ),
                    const SizedBox(height: 12),
                    _buildReviewsSection(
                      restaurant.id,
                      restaurant.customerReviews,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(RestaurantDetailItem restaurant) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'restaurant-${restaurant.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: ApiService.getLargeImageUrl(restaurant.pictureId),
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant, size: 80),
                    ),
              ),
              // Gradient overlay for better text visibility
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 18),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share feature coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorite feature coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRestaurantInfo(RestaurantDetailItem restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${restaurant.rating.toStringAsFixed(1)} / 5.0',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Restaurant rating detail
        RatingBarIndicator(
          rating: restaurant.rating,
          itemBuilder:
              (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.secondary,
              ),
          itemSize: 24,
        ),
        const SizedBox(height: 16),

        // Restaurant address
        IntrinsicHeight(
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              ),
              Expanded(
                child: Text(
                  '${restaurant.address}, ${restaurant.city}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList(List<Category> categories) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          categories.map((category) {
            return Chip(
              label: Text(category.name),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            );
          }).toList(),
    );
  }

  Widget _buildMenus(Menus menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Foods section
        _buildMenuSection(
          title: 'Makanan',
          items: menus.foods.map((food) => food.name).toList(),
          icon: Icons.restaurant_menu,
          color: Colors.green,
        ),
        const SizedBox(height: 16),

        // Drinks section
        _buildMenuSection(
          title: 'Minuman',
          items: menus.drinks.map((drink) => drink.name).toList(),
          icon: Icons.local_bar,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              items.map((item) {
                return Chip(
                  label: Text(item),
                  backgroundColor: color.withOpacity(0.1),
                  labelStyle: TextStyle(color: color),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  avatar: Icon(icon, size: 16, color: color),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewsSection(
    String restaurantId,
    List<CustomerReview> reviews,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Add review form
        ReviewForm(restaurantId: restaurantId),
        const SizedBox(height: 16),

        // Review list title
        Text(
          'Semua Ulasan (${reviews.length})',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        if (reviews.isEmpty)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/empty_box.json',
                  width: 150,
                  height: 150,
                ),
                Text(
                  'Belum ada ulasan',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _buildReviewItem(review);
            },
          ),
      ],
    );
  }

  Widget _buildReviewItem(CustomerReview review) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? Theme.of(context).cardTheme.color?.withOpacity(0.7)
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                child: Center(
                  child: Text(
                    review.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      review.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      review.date,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review.review, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
