import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:theone_dipeshpracticle/src/initial_page.dart';
import 'package:theone_dipeshpracticle/src/player/video_player.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const InitialPage());
      case '/player':
        if (arguments is Map<String, String>) {
          if (kDebugMode) {
            print('RouteGenerator : $arguments');
          }
          return MaterialPageRoute(
              builder: (context) => VideoPlayerPage(arguments));
        }
        return _errorWidgets();

      default:
        return _errorWidgets();
    }
  }

  static Route<dynamic> _errorWidgets() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page Not Found!'),
        ),
      );
    });
  }
}
