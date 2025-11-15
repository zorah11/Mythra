import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/local_data_service.dart';

class TribeDetailScreen extends StatelessWidget {
  final String tribeSlug;
  final String tribeName;

  const TribeDetailScreen({
    super.key,
    required this.tribeSlug,
    required this.tribeName,
  });

  String _getTribeDescription(String slug) {
    switch (slug) {
      case 'buganda':
        return 'The Baganda people are the largest ethnic group in Uganda. Their rich cultural heritage includes the story of Kintu and Nambi, which explains the origins of the Baganda people and the introduction of death to the world.';
      default:
        return 'Explore the rich mythological traditions of the $tribeName people.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LocalDataService>(context);
    final stories = data.search('', tribe: tribeSlug);

    return Scaffold(
      appBar: AppBar(title: Text(tribeName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tribeName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getTribeDescription(tribeSlug),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Stories from $tribeName',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (context, i) {
                final s = stories[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
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
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/story',
                        arguments: {'story': s},
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
