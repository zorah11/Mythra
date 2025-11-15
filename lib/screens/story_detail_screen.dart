import 'package:flutter/material.dart';
import '../models/story.dart';

class StoryDetailScreen extends StatelessWidget {
  static const routeName = '/story';
  final Story? story;

  const StoryDetailScreen({super.key, this.story});

  @override
  Widget build(BuildContext context) {
    final s = story;
    if (s == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Story')),
        body: const Center(child: Text('Story not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(s.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon!')),
              );
            },
            tooltip: 'Share story',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 300,
                  child: Image.asset(
                    s.image,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.5),
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.image_not_supported, size: 64),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text(s.tribeName)),
                  const SizedBox(height: 8),
                  Text(
                    s.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    s.fullText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
