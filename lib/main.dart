import 'package:beakingbad/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    myRoute: MyRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  final MyRoutes myRoute;

  const MyApp({super.key, required this.myRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //   home: Scaffold(),
      onGenerateRoute: myRoute.myRoutes,
    );
  }
}
