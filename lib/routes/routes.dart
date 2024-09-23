import 'package:flutter/material.dart';
import 'package:stars/pages/favourites_page.dart';
import 'package:stars/pages/home_page.dart';
import 'package:stars/pages/loading_page.dart';
import 'package:stars/pages/main_page.dart';
import 'package:stars/pages/profile_page.dart';
import 'package:stars/pages/search_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'main': (_) => const MainPage(),
};

List<Widget> pages = [
  const HomePage(),
  const SearchPage(),
  const FavouritesPage(),
  const ProfilePage(),
];
