import 'package:edermanapp/view/components/theme/stateful.dart';
import 'package:flutter/material.dart';

class CartScreen extends ThemedStatefulWidget {
  const CartScreen({super.key});

  @override
  ThemedState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ThemedState<CartScreen> {
  @override
  Widget buildWithTheme(BuildContext context, bool isDarkMode) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('В разработке - Корзина')],
        ),
      ),
    );
  }
}
