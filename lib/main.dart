import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const QuickShopApp());
}

class QuickShopApp extends StatelessWidget {
  const QuickShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}