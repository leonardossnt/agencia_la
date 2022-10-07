import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class Auth {
  static Future<Object> init() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (FirebaseAuth.instance.currentUser != null) {
      print('currentUser is present! proceed to enter app');
      //enterApp();
    } else {
      print('currentUser is null! proceed to login');
    }

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
      // await user!.updateProfile(displayName: email);
      // await user.reload();
      // user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        response.add(false);
        response.add('Senha fraca');
        return response;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        response.add(false);
        response.add('Email já cadastrado.');
        return response;
      }
    } catch (e) {
      print(e);
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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        response.add(false);
        response.add('Usuário não encontrado.');
        return response;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        response.add(false);
        response.add('Senha incorreta.');
        return response;
      }
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