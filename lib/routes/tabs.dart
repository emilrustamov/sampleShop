import 'package:edermanapp/view/screen/tabs/cart.dart';
import 'package:edermanapp/view/screen/tabs/catalog.dart';
import 'package:edermanapp/view/screen/tabs/favorites.dart';
import 'package:edermanapp/view/screen/tabs/home.dart';
import 'package:edermanapp/view/screen/tabs/profile.dart';
import 'package:flutter/material.dart';

List<TabDataModel> tabData = [
  TabDataModel(
    // icon: CoreIcons.tabHome,
    icon: Icons.home,
    label: 'tab_home',
    screen: const HomeScreen(),
  ),
  TabDataModel(
    // icon: CoreIcons.tabSearch,
    icon: Icons.search,
    label: 'tab_catalog',
    screen: const CatalogScreen(),
  ),
  TabDataModel(
    // icon: CoreIcons.tabCart,
    icon: Icons.shopping_cart,
    label: 'tab_cart',
    badge: true,
    screen: const CartScreen(),
  ),
  TabDataModel(
    // icon: CoreIcons.tabFavs,
    icon: Icons.favorite,
    label: 'tab_favorites',
    screen: const FavoritesScreen(),
  ),
  TabDataModel(
    // icon: CoreIcons.tabProfile,
    icon: Icons.person,
    label: 'tab_profile',
    screen: const ProfileScreen(),
  ),
];

class TabDataModel {
  Widget screen;
  // String? icon;
  IconData? icon;
  String label;
  bool badge;
  var navigatorKey = GlobalKey<NavigatorState>();
  TabDataModel({required this.screen, required this.icon, required this.label, this.badge = false});
}
