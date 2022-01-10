import 'package:flutter/material.dart';
import 'package:my_trainings_app/features/landing/screens/home_screen.dart';
import 'package:my_trainings_app/utils/colors.dart';
import 'package:my_trainings_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Training App',
      theme: ThemeData(
        primaryColor: colorRed,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: "Poppins"),
      ),
      onGenerateRoute: appGenerateRoute(),
      initialRoute: HomeScreen.route,
    );
  }
}
