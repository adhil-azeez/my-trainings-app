import 'package:flutter/material.dart';
import 'package:my_trainings_app/features/landing/screens/home_screen.dart';

RouteFactory? appGenerateRoute() => (settings) {
      Widget? screen;
      switch (settings.name) {
        case HomeScreen.route:
          screen = const HomeScreen();
          break;
      }
      if (screen != null) {
        return MaterialPageRoute(
          builder: (context) => screen!,
        );
      }
    };
