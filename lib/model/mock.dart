import 'lanny.dart';
import 'order.dart';

class Mock {
  static final lanny = Lanny(name: "Giovana", age: 25, phone: "(92) 99999-9999", picture: "assets/images/logo_navy.png");
  static final order = Order(lanny: lanny, dateTime: "21/10 às 17:00", duration: "2h", address: "Rua Pará, 476 - Vieiralves, Cond. Smart Town Apt 2, Bl 8. CEP: 69099-000");
}
