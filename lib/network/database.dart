import 'package:agencia_la/model/client.dart';
import 'package:agencia_la/model/lanny.dart';
import 'package:agencia_la/model/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future registerUser(User user, Client client) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref('client/${user.uid}');
    await ref.set(client.toJson());
  }

  static Future<dynamic> getOngoingOrdersByClient(String uid) async {
    FirebaseDatabase db = FirebaseDatabase.instance;

    // first: get all orders
    var snapshotAllOrders = await db.ref('orders').get();

    if (!snapshotAllOrders.exists) {
      return null;
    }

    var allOrders = snapshotAllOrders.value as List;

    // second: get all lannies
    var snapshotAllLannies = await db.ref('lanny').get();

    if (!snapshotAllLannies.exists) {
      return null;
    }

    var allLannies = snapshotAllLannies.value as List;

    // third: get all ongoing orders from client
    var clientOngoingOrders = await db.ref('client/$uid/ongoingOrders').get();

    if (!clientOngoingOrders.exists) {
      return null;
    }

    var ongoingOrdersKeys = clientOngoingOrders.value as List;

    // fourth: create a list of orders
    List<Order> ongoingOrders = [];

    for (var orderKey in ongoingOrdersKeys) {
      var orderJson = allOrders[orderKey];
      var lannyJson = allLannies[orderJson["lanny"]];

      var lanny = Lanny.fromJson(lannyJson);
      var order = Order.fromJson(orderJson, lanny);
      ongoingOrders.add(order);
    }

    return ongoingOrders;
  }
}