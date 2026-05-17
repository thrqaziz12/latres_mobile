class SpaceItem {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String url;
  final String publishedAt;
  final String newsSite;
  final List<String> authors;

  SpaceItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
    required this.newsSite,
    required this.authors,
  });

  factory SpaceItem.fromJson(Map<String, dynamic> json) {
    List<String> parseAuthors(dynamic raw) {
      if (raw == null) return [];
      if (raw is List) {
        return raw
            .map((e) {
              if (e is String) return e;
              if (e is Map) return (e['name'] ?? '').toString();
              return '';
            })
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    return SpaceItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      imageUrl: json['image_url'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['published_at'] ?? '',
      newsSite: json['news_site'] ?? '',
      authors: parseAuthors(json['authors']),
    );
  }

  String get authorsDisplay =>
      authors.isNotEmpty ? authors.join(', ') : newsSite;

  String get formattedDate {
    try {
      final dt = DateTime.parse(publishedAt).toLocal();
      const m = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agu',
        'Sep',
        'Okt',
        'Nov',
        'Des',
      ];
      return '${dt.day} ${m[dt.month]} ${dt.year}';
    } catch (_) {
      return publishedAt;
    }
  }
}
