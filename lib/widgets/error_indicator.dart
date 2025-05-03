import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorIndicator({
    super.key,
    this.message = 'Terjadi kesalahan saat memuat data.',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Cek apakah pesan error berkaitan dengan koneksi internet
    bool isConnectionError =
        message.toLowerCase().contains('koneksi') ||
        message.toLowerCase().contains('internet') ||
        message.toLowerCase().contains('network') ||
        message.toLowerCase().contains('socket');

    // Pesan bantuan berdasarkan jenis error
    String helpMessage =
        isConnectionError
            ? 'Pastikan perangkat Anda terhubung ke internet dan coba lagi.'
            : 'Maaf, terjadi kesalahan. Silakan coba lagi nanti.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Lottie.asset(
                'assets/animations/error.json',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isConnectionError
                  ? 'Tidak Ada Koneksi Internet'
                  : 'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              helpMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            if (isConnectionError && onRetry != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Bantuan Koneksi'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Langkah yang dapat dilakukan:'),
                                const SizedBox(height: 8),
                                _buildHelpItem(
                                  context,
                                  '1. Periksa koneksi WiFi atau data seluler Anda',
                                ),
                                _buildHelpItem(
                                  context,
                                  '2. Mode pesawat tidak aktif',
                                ),
                                _buildHelpItem(
                                  context,
                                  '3. Coba gunakan jaringan lain jika tersedia',
                                ),
                                _buildHelpItem(
                                  context,
                                  '4. Restart perangkat jika diperlukan',
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tutup'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  onRetry!();
                                },
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                    );
                  },
                  child: const Text('Butuh Bantuan?'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
