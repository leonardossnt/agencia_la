import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class Auth {
  static const errorMap = {
    'weak-password': {
      'log': "The password provided is too weak",
      'message': "Senha fraca.",
    },
    'email-already-in-use': {
      'log': "The account already exists for that email.",
      'message': "Email já cadastrado.",
    },
    'network-request-failed': {
      'log': "Network request failed; device is not connected.",
      'message': "Sem conexão com a internet.",
    },
    'user-not-found': {
      'log': "No user found for that email.",
      'message': "Usuário não encontrado.",
    },
    'wrong-password': {
      'log': "Wrong password provided.",
      'message': "Senha incorreta.",
    }
  };

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
      return parseError(e.code);
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
      return parseError(e.code);
    }

    response.add(true);
    response.add(user);
    return response;
  }

  static List<dynamic> parseError(String errorCode) {
    List<dynamic> response = [];
    response.add(false);

    var logError = errorMap[errorCode]?['log'] ??
        "Erro desconhecido: $errorCode";
    print(logError);

    var userError = errorMap[errorCode]?['message'] ??
        "Erro desconhecido. Tente novamente.";
    response.add(userError);

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
