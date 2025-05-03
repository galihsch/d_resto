import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'restaurant_provider.dart';
import '../data/api/api_service.dart';

class ReviewFormProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  Future<void> submitReview({
    required String restaurantId,
    required RestaurantProvider restaurantProvider,
    required BuildContext context,
  }) async {
    setSubmitting(true);

    try {
      await restaurantProvider.postReview(
        id: restaurantId,
        name: nameController.text.trim(),
        review: reviewController.text.trim(),
      );

      // Reset form
      nameController.clear();
      reviewController.clear();

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review berhasil dikirim'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim review: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setSubmitting(false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }
}
