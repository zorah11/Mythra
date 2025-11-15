import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/local_data_service.dart';
import 'tribe_detail_screen.dart';

class TribesScreen extends StatelessWidget {
  const TribesScreen({super.key});

  String _getTribeDisplayName(String slug) {
    switch (slug) {
      case 'buganda':
        return 'Buganda';
      case 'acholi':
        return 'Acholi';
      case 'langi':
        return 'Langi';
      default:
        return slug[0].toUpperCase() + slug.substring(1);
    }
  }

  int _getStoryCount(BuildContext context, String slug) {
    final data = Provider.of<LocalDataService>(context, listen: false);
    return data.search('', tribe: slug).length;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LocalDataService>(context);
    final tribes = data.tribes();

    return Scaffold(
      appBar: AppBar(title: const Text('Tribes')),
      body: ListView.builder(
        itemCount: tribes.length,
        itemBuilder: (context, i) {
          final slug = tribes[i];
          final displayName = _getTribeDisplayName(slug);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.people_outline, size: 40),
              title: Text(
                displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_getStoryCount(context, slug)} ${_getStoryCount(context, slug) == 1 ? "story" : "stories"}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TribeDetailScreen(
                      tribeSlug: slug,
                      tribeName: displayName,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) Navigator.pushReplacementNamed(context, '/');
          if (i == 2) Navigator.pushReplacementNamed(context, '/settings');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Stories'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tribes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
