import 'package:flutter/material.dart';

class UtilSplashScreen extends StatefulWidget {
  const UtilSplashScreen({super.key});

  @override
  State<UtilSplashScreen> createState() => _UtilSplashScreenState();
}

class _UtilSplashScreenState extends State<UtilSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Сплеш скрин'),
      ),
    );
  }
}
