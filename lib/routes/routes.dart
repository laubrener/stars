import 'package:flutter/material.dart';
import 'package:stars/pages/home_page.dart';
import 'package:stars/pages/loading_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'home': (_) => const HomePage(),
};
