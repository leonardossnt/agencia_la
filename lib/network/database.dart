import 'dart:collection';

import 'package:agencia_la/model/client.dart';
import 'package:agencia_la/model/lanny.dart';
import 'package:agencia_la/model/order.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  static Future registerUser(User user, Client client) async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref('client/${user.uid}');
    await ref.set(client.toJson());
  }

  static dynamic getAllOrdersAndLannies() async {
    FirebaseDatabase db = FirebaseDatabase.instance;

    // first: get all orders
    var snapshotAllOrders = await db.ref('orders').get();

    if (!snapshotAllOrders.exists) {
      return null;
    }

    var allOrders = snapshotAllOrders.value as LinkedHashMap<Object?, Object?>;

    // second: get all lannies
    var snapshotAllLannies = await db.ref('lanny').get();

    if (!snapshotAllLannies.exists) {
      return null;
    }

    var allLannies = snapshotAllLannies.value as List;

    return {'orders': allOrders, 'lannies': allLannies};
  }

  static Future<dynamic> getOngoingOrdersByClient(String uid) async {
    FirebaseDatabase db = FirebaseDatabase.instance;

    var all = await getAllOrdersAndLannies();
    var allOrders = all['orders'];
    var allLannies = all['lannies'];

    // get all ongoing orders from client
    var clientOngoingOrders = await db.ref('client/$uid/ongoingOrders').get();

    if (!clientOngoingOrders.exists) {
      return null;
    }

    var ongoingOrdersKeys = clientOngoingOrders.value as List;

    // create a list of orders
    List<Order> ongoingOrders = [];

    for (var orderKey in ongoingOrdersKeys) {
      var orderJson = allOrders[orderKey];
      var lanny;
      if (orderJson["lanny"] != null) {
        var lannyJson = allLannies[orderJson["lanny"]];
        lanny = Lanny.fromJson(lannyJson);
      }

      var order = Order.fromJson(orderJson, lanny);
      ongoingOrders.add(order);
    }

    return ongoingOrders;
  }

  static Future<dynamic> getFinishedOrdersByClient(String uid) async {
    FirebaseDatabase db = FirebaseDatabase.instance;

    var all = await getAllOrdersAndLannies();
    var allOrders = all['orders'];
    var allLannies = all['lannies'];

    // get all ongoing orders from client
    var clientFinishedOrders = await db.ref('client/$uid/finishedOrders').get();

    if (!clientFinishedOrders.exists) {
      return null;
    }

    var finishedOrdersKeys = clientFinishedOrders.value as List;

    // create a list of orders
    List<Order> finishedOrders = [];

    for (var orderKey in finishedOrdersKeys) {
      var orderJson = allOrders[orderKey];
      var lanny;
      if (orderJson["lanny"] != null) {
        var lannyJson = allLannies[orderJson["lanny"]];
        lanny = Lanny.fromJson(lannyJson);
      }

      var order = Order.fromJson(orderJson, lanny);
      finishedOrders.add(order);
    }

    return finishedOrders;
  }

  static Future<void> updateClientInfo(Client client, String? newPassword) async {
     FirebaseDatabase db = FirebaseDatabase.instance;
    DatabaseReference ref = db.ref("client/${Auth.getCurrentUser()?.uid}/info");

    if(newPassword != null && newPassword.length >= 8){
      await Auth.getCurrentUser()?.updatePassword(newPassword);
    }

    await ref.update({
      "name" : client.name,
      "surname" : client.surname,
      "phone" : client.phone,
      "email" : client.email
    });
  }

  static Future<String> getClientFullname() async {
    final ref = FirebaseDatabase.instance.ref();
    dynamic userInfo =
        await ref.child('client/${Auth.getCurrentUser()!.uid}/info').get();
    if (userInfo.exists) {
      String name = userInfo.value['name'] + ' ' + userInfo.value['surname'];
      return name;
    } else {
      return '';
    }
  }

  static Future<String> getClientPicture() async {
    final ref = FirebaseDatabase.instance.ref();
    dynamic userInfo =
      await ref.child('client/${Auth.getCurrentUser()!.uid}/info').get();
    if (userInfo.exists) {
      String url = userInfo.value['picture'];
      return url;
    } else {
      return '';
    }
  }

  static Future<bool> addOrder(String uid, Order order) async {
    final ordersRef = FirebaseDatabase.instance.ref("orders");
    var newOrderRef = ordersRef.push();
    var newOrderKey = newOrderRef.key as String;
    await newOrderRef.set(order.toJson());

    final clientRef = FirebaseDatabase.instance.ref("client/$uid/ongoingOrders");
    DataSnapshot snapshot = await clientRef.get();
    if (!snapshot.exists) return false;

    var ongoingOrders = [];
    if (snapshot.value != "") {
      ongoingOrders.addAll(snapshot.value as List);
    }
    ongoingOrders.add(newOrderKey);
    await clientRef.set(ongoingOrders);
    return true;
  }
}