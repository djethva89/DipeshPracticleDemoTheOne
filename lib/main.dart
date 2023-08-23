import 'package:flutter/material.dart';
import 'package:theone_dipeshpracticle/routes/routes_generator.dart';

import 'locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MaterialApp(
    color: Colors.white,
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoutes,
  ));
}
