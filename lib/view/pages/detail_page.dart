import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/detail_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  void _openUrl(BuildContext context, String url) async {
    // Tampilkan URL di dialog karena tidak pakai url_launcher
    // Jika ingin buka browser, tambahkan package url_launcher
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF141B2D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'Sumber Artikel',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: SelectableText(
          url,
          style: const TextStyle(color: Color(0xFF4F8EF7), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Tutup',
              style: TextStyle(color: Color(0xFF4F8EF7)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<DetailController>();
    final args = Get.arguments as Map<String, dynamic>;
    final menuTitle = args['menuTitle'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('$menuTitle Detail'),
        leading: const BackButton(),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF4F8EF7)),
          );
        }
        if (ctrl.errorMsg.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Gagal memuat detail',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: ctrl.fetchDetail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F8EF7),
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final item = ctrl.item.value!;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image
              item.imageUrl.isNotEmpty
                  ? Image.network(
                      item.imageUrl,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 240,
                        color: const Color(0xFF1C2740),
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.white24,
                          size: 64,
                        ),
                      ),
                    )
                  : Container(
                      height: 240,
                      color: const Color(0xFF1C2740),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        color: Color(0xFF4F8EF7),
                        size: 64,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Author
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Color(0xFF4F8EF7),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.authorsDisplay,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4F8EF7),
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.white.withOpacity(0.45),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white.withOpacity(0.1)),
                    const SizedBox(height: 16),
                    // Summary
                    const Text(
                      'Ringkasan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.summary.isNotEmpty
                          ? item.summary
                          : 'Tidak ada ringkasan tersedia.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(
        () => ctrl.item.value != null
            ? FloatingActionButton.extended(
                onPressed: () => _openUrl(context, ctrl.item.value!.url),
                backgroundColor: const Color(0xFF4F8EF7),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text(
                  'Buka Sumber',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
