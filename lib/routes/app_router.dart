import 'package:flutter/material.dart';
import 'package:my_notes/routes/app_routes.dart';
import 'package:my_notes/screens/home_screen.dart';
import 'package:my_notes/screens/note_screen.dart';


// t1
// test2
class AppRouter {
  AppRouter._();
  // added comment
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.notes:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NoteScreen(),
        );
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not found')),
        body: Center(child: Text('No screen named "${settings.name}"')),
      ),
    );
  }
}