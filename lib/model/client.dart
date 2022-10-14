import 'order.dart';

class Client {
  String name;
  String surname;
  String phone;
  String email;
  String? picture;
  List<String>? addresses; // TODO: change to List<Address>
  List<String>? children; // TODO: change to List<Child>
  List<Order>? finishedOrders;
  List<Order>? ongoingOrders;

  Client({
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
  });

  Object toJson() {
    return {
      "info": {
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
      },
      "addresses": addresses ?? "",
      "children": children ?? "",
      "finishedOrders": finishedOrders ?? "",
      "ongoingOrders": ongoingOrders ?? "",
    };
  }
}
