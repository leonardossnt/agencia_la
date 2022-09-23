import 'package:flutter/material.dart';
import 'package:agencia_la/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // TODO: change to centralized theme
          primarySwatch: Colors.teal,
        ),
        // TODO: Selector to Login or Home if user is logged in
        home: LoginScreen());
  }
}
