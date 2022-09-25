import 'package:agencia_la/auth/auth.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
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
        home: FutureBuilder(
          future: Auth.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("Firebase initialized!");

              if (Auth.getCurrentUser() != null) {
                return ClientMainScreen();
              } else {
                return LoginScreen();
              }
            }
            return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
              )
            );
          },
        )
    );
  }
}