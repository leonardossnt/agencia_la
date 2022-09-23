import 'package:flutter/material.dart';
import 'package:agencia_la/app/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:agencia_la/firebase_options.dart';

void main() {
  initFirebase();

  runApp(const MyApp());
}

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
