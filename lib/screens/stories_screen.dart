import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/local_data_service.dart';
import '../models/story.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LocalDataService>(context);
    final stories = data.search(_query);

    return Scaffold(
      appBar: AppBar(title: const Text('Mythra — Stories')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search a myth...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: data.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: stories.length,
                    itemBuilder: (context, i) {
                      final s = stories[i];
                      return ListTile(
                        leading: SizedBox(
                          width: 72,
                          height: 56,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              s.thumbnail,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        title: Text(s.title),
                        subtitle: Text(s.shortDescription),
                        trailing: Text(s.tribeName),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/story',
                            arguments: {'story': s},
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) Navigator.pushReplacementNamed(context, '/tribes');
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
