import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Theme'),
                Switch(
                  value: theme.isDark,
                  onChanged: (v) => theme.toggleTheme(v),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Font Size'),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Small'),
                  selected: theme.fontIndex == 0,
                  onSelected: (_) => theme.setFontIndex(0),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Medium'),
                  selected: theme.fontIndex == 1,
                  onSelected: (_) => theme.setFontIndex(1),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Large'),
                  selected: theme.fontIndex == 2,
                  onSelected: (_) => theme.setFontIndex(2),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'About Mythra',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mythra is an offline children\'s app celebrating Uganda\'s myths and cultural stories.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) Navigator.pushReplacementNamed(context, '/');
          if (i == 1) Navigator.pushReplacementNamed(context, '/tribes');
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
