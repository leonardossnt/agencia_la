import 'package:agencia_la/model/client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future registerUser(User user, Client client) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref('client/${user.uid}');
    await ref.set(client.toJson());
  }
}