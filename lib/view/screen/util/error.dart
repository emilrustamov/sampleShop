import 'package:flutter/material.dart';

class UtilErrorScreen extends StatefulWidget {
  const UtilErrorScreen({super.key});

  @override
  State<UtilErrorScreen> createState() => _UtilErrorScreenState();
}

class _UtilErrorScreenState extends State<UtilErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text('Error скрин'),
        ),
      ]),
    );
  }
}
