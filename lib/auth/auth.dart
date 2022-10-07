import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class Auth {
  static Future<Object> init() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return firebaseApp;
  }

  static Future<dynamic> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    List<dynamic> response = [];
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      response.add(false);

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        response.add('Senha fraca');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        response.add('Email já cadastrado.');
      } else if (e.code == 'network-request-failed') {
        response.add('Sem conexão com a internet.');
      } else {
        print("Erro desconhecido: ${e.code}");
        response.add('Erro desconhecido. Tente novamente.');
      }
      return response;
    }

    response.add(true);
    response.add(user);
    return response;
  }

  static Future<dynamic> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    List<dynamic> response = [];

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      response.add(false);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        response.add('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        response.add('Senha incorreta.');
      } else if (e.code == 'network-request-failed') {
        print('Network request failed.');
        response.add('Sem conexão com a internet.');
      } else {
        print("Erro desconhecido: ${e.code}");
        response.add('Erro desconhecido. Tente novamente.');
      }

      return response;
    }

    response.add(true);
    response.add(user);
    return response;
  }

  static User? getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return user;
  }

  static void clearCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }
}