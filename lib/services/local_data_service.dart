import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/story.dart';

class LocalDataService extends ChangeNotifier {
  List<Story> _stories = [];
  bool _loading = false;

  List<Story> get stories => _stories;
  bool get loading => _loading;

  Future<void> loadStories() async {
    _loading = true;
    notifyListeners();
    try {
      final raw = await rootBundle.loadString('assets/stories/stories.json');
      final data = jsonDecode(raw) as List<dynamic>;
      _stories = data
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // keep list empty on error
      _stories = [];
      if (kDebugMode) print('Error loading stories: $e');
    }
    _loading = false;
    notifyListeners();
  }

  Story? getById(String id) {
    try {
      return _stories.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Story> search(String query, {String? tribe}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty && tribe == null) return List.from(_stories);
    final results = _stories.where((s) {
      final title = s.title.toLowerCase();
      final tribeName = s.tribeName.toLowerCase();
      final keywords = s.keywords.join(' ').toLowerCase();
      final short = s.shortDescription.toLowerCase();
      final full = s.fullText.toLowerCase();
      final tribeMatch = tribe == null ? true : s.tribe == tribe;
      final found =
          title.contains(q) ||
          tribeName.contains(q) ||
          keywords.contains(q) ||
          short.contains(q) ||
          full.contains(q);
      return tribeMatch && (q.isEmpty ? true : found);
    }).toList();
    return results;
  }

  List<String> tribes() {
    final set = <String, String>{};
    for (final s in _stories) {
      if (!set.containsKey(s.tribe)) set[s.tribe] = s.tribeName;
    }
    // return tribe slugs in alphabetical order of display name
    final entries = set.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return entries.map((e) => e.key).toList();
  }
}
