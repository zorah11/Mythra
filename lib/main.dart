import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'services/local_data_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localData = LocalDataService();
  await localData.loadStories();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => localData),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MythraApp(),
    ),
  );
}
