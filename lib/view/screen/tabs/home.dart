import 'package:edermanapp/view/components/theme/stateful.dart';
import 'package:flutter/material.dart';

class HomeScreen extends ThemedStatefulWidget {
  const HomeScreen({super.key});

  @override
  ThemedState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ThemedState<HomeScreen> {
  @override
  Widget buildWithTheme(BuildContext context, bool isDarkMode) {
    return const Scaffold(body: Center(child: Text('Home')));
  }
}
