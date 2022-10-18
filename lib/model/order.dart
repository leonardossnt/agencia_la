import 'lanny.dart';

class Order {
  Lanny lanny;
  String date;
  String time;
  String duration;
  String address;
  bool finished;

  Order({
      required this.lanny,
      required this.date,
      required this.time,
      required this.duration,
      required this.address,
      required this.finished
  });

  static Order fromJson(dynamic data, Lanny lanny) {
    return Order(
        lanny: lanny,
        date: data["date"],
        time: data["time"],
        duration: data["duration"],
        address: data["address"],
        finished: data["finished"]
    );
  }
}
