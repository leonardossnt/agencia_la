import 'package:agencia_la/model/client.dart';
import 'package:agencia_la/network/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class RegisterClient {
  static Future<dynamic> registerClient(Client client, String password) async {
    List<dynamic> response = [];

    // try to register
    response = await Auth.registerUsingEmailPassword(
        email: client.email, password: password);

    if (response[0] == true) {
      // authentication sign up succeeded; now, register user info on database
      User user = response[1];
      await Database.registerUser(user, client);
    }
    return response;
  }
}
