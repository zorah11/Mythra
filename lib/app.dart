import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'services/local_data_service.dart';
import 'screens/stories_screen.dart';
import 'screens/tribes_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/story_detail_screen.dart';

class MythraApp extends StatelessWidget {
  const MythraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) {
        final base = ThemeData(
          primaryColor: const Color(0xFFE5A523),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE5A523)),
          useMaterial3: true,
        );

        final light = base.copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        );

        final dark = base.copyWith(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
            foregroundColor: Colors.white,
            elevation: 2,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF1F1F1F),
            selectedItemColor: Color(0xFFE5A523),
            unselectedItemColor: Colors.white70,
          ),
          textTheme: base.textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white70,
          ),
          chipTheme: ChipThemeData(
            backgroundColor: const Color(0xFF2A2A2A),
            labelStyle: const TextStyle(color: Colors.white),
            secondaryLabelStyle: const TextStyle(color: Colors.white),
            brightness: Brightness.dark,
          ),
          cardTheme: const CardThemeData(color: Color(0xFF1F1F1F)),
        );

        return MaterialApp(
          title: 'Mythra',
          debugShowCheckedModeBanner: false,
          theme: light,
          darkTheme: dark,
          themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaleFactor: theme.fontScale),
              child: child ?? const SizedBox.shrink(),
            );
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const StoriesScreen(),
            '/tribes': (context) => const TribesScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == StoryDetailScreen.routeName) {
              final args = settings.arguments as Map<String, dynamic>?;
              return MaterialPageRoute(
                builder: (_) => StoryDetailScreen(story: args?['story']),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
