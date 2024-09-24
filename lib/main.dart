import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/routes/routes.dart';

import 'providers/movies_provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData.dark().copyWith(
        indicatorColor: const Color(0xff576ca8),
        primaryColorLight: Colors.white,
        primaryColor: Color(int.parse('0xff2A0B51')),
        scaffoldBackgroundColor: Color(int.parse('0xff2A0B51')),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          elevation: 1,
          selectedItemColor: Color(0xff576ca8),
          selectedIconTheme: IconThemeData(color: Color(0xff576ca8)),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
        ),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
          color: Colors.white,
        )));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: appRoutes,
      initialRoute: 'details',
      theme: themeData,
      // theme: ThemeData.dark().copyWith(
      //     // primaryColor: Colors.purple,
      //     bottomNavigationBarTheme:
      //         BottomNavigationBarThemeData(backgroundColor: Colors.green),
      //     colorScheme: ColorScheme(
      //       brightness: Brightness.dark,
      //       primary: Colors.purple.shade200,
      //       onPrimary: Colors.purple.shade300,
      //       secondary: Colors.pink,
      //       onSecondary: Colors.pinkAccent,
      //       error: Colors.red,
      //       onError: Colors.red.shade600,
      //       background: Colors.purple.shade900,
      //       onBackground: Colors.purple.shade700,
      //       surface: Colors.grey,
      //       onSurface: Colors.purpleAccent,
      //     )),
    );
  }
}
