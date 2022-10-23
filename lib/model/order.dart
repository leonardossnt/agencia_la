import 'package:agencia_la/model/child.dart';
import 'lanny.dart';

class Order {
  Lanny? lanny;
  Child child; // TODO: make this a List<Child>
  String date;
  String time;
  String duration;
  String address;
  String status;

  Order({
      this.lanny,
      required this.child,
      required this.date,
      required this.time,
      required this.duration,
      required this.address,
      required this.status
  });

  static Order fromJson(dynamic data, Lanny lanny) {
    return Order(
        lanny: lanny,
        child: Child.fromJson(data["children"]), // TODO: fix this when children is a List
        date: data["date"],
        time: data["time"],
        duration: data["duration"],
        address: data["address"],
        status: data["status"]
    );
  }
}
