import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/theme_provider.dart';
import 'package:untitled6/weather_provider.dart';
import 'package:untitled6/weather_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: themeProvider.isDark ? ThemeData.dark() : ThemeData.light(),
      home: const WeatherScreen(),
    );
  }
}
