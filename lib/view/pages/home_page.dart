import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AuthController.getSavedUsername(),
      builder: (context, snap) {
        final username = snap.data ?? '';
        return Scaffold(
          appBar: AppBar(
            title: Text('Hai, $username!'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_rounded),
                tooltip: 'Logout',
                onPressed: () => Get.find<AuthController>().logout(),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.public_rounded,
                    size: 64,
                    color: Color(0xFF4F8EF7),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Space Flight News',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pilih kategori berita',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _MenuCard(
                    title: 'News',
                    subtitle: 'Berita terbaru dunia antariksa',
                    icon: Icons.newspaper_rounded,
                    color: const Color(0xFF4F8EF7),
                    onTap: () => Get.toNamed(
                      AppRoutes.list,
                      arguments: {'type': 'articles', 'title': 'News'},
                    ),
                  ),
                  const SizedBox(height: 16),
                  _MenuCard(
                    title: 'Blog',
                    subtitle: 'Artikel dan opini seputar luar angkasa',
                    icon: Icons.article_rounded,
                    color: const Color(0xFF9C6FE4),
                    onTap: () => Get.toNamed(
                      AppRoutes.list,
                      arguments: {'type': 'blogs', 'title': 'Blog'},
                    ),
                  ),
                  const SizedBox(height: 16),
                  _MenuCard(
                    title: 'Report',
                    subtitle: 'Laporan resmi dan teknis antariksa',
                    icon: Icons.description_rounded,
                    color: const Color(0xFF2ECC71),
                    onTap: () => Get.toNamed(
                      AppRoutes.list,
                      arguments: {'type': 'reports', 'title': 'Report'},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141B2D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}
