import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/space_item.dart';

class ApiService {
  static const _base = 'https://api.spaceflightnewsapi.net/v4';

  static Future<List<SpaceItem>> fetchList(
    String type, {
    int limit = 10,
    int offset = 0,
  }) async {
    final res = await http.get(
      Uri.parse('$_base/$type/?limit=$limit&offset=$offset'),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data['results'] as List)
          .map((e) => SpaceItem.fromJson(e))
          .toList();
    }
    throw Exception('Gagal memuat data (${res.statusCode})');
  }

  static Future<SpaceItem> fetchDetail(String type, int id) async {
    final res = await http.get(Uri.parse('$_base/$type/$id/'));
    if (res.statusCode == 200) {
      return SpaceItem.fromJson(jsonDecode(res.body));
    }
    throw Exception('Gagal memuat detail (${res.statusCode})');
  }
}
