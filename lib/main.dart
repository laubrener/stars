import 'package:flutter/material.dart';
import 'package:stars/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: appRoutes,
      initialRoute: 'home',
      theme: ThemeData.dark().copyWith(
          // primaryColor: Colors.purple,
          colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.purple.shade200,
        onPrimary: Colors.purple.shade300,
        secondary: Colors.pink,
        onSecondary: Colors.pinkAccent,
        error: Colors.red,
        onError: Colors.red.shade600,
        background: Colors.purple.shade900,
        onBackground: Colors.purple.shade700,
        surface: Colors.grey,
        onSurface: Colors.purpleAccent,
      )),
    );
  }
}
