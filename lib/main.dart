import 'package:flutter/material.dart';
import 'package:portfolio_web/screens/home_screen.dart';
import 'package:portfolio_web/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Specialist | Flutter & Android Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: true,
      ),
    );
  }
}
