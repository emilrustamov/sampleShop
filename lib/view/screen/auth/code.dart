import 'package:flutter/material.dart';

class AuthCodeScreen extends StatefulWidget {
  const AuthCodeScreen({super.key});

  @override
  State<AuthCodeScreen> createState() => _AuthCodeScreenState();
}

class _AuthCodeScreenState extends State<AuthCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Подтверждение номера телефона'),
      ),
    );
  }
}
