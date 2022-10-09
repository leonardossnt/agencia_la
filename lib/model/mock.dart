import 'lanny.dart';
import 'order.dart';

class Mock {
  static final lannies = [
    Lanny(name: "Giovana", age: 25, phone: "(92) 99999-9999", picture: "assets/images/mock01.jpg"),
    Lanny(name: "Luiza", age: 21, phone: "(92) 99999-9999", picture: "assets/images/mock02.jpg"),
  ];
  static final orders = [
    Order(lanny: lannies[0], date: "21/10", time: "17:00", duration: "2h", address: "Rua Pará, 476 - Vieiralves, Cond. Smart Town Apt 2, Bl 8. CEP: 69099-000"),
    Order(lanny: lannies[1], date: "06/10", time: "19:00", duration: "3h", address: "Rua Pará, 476 - Vieiralves, Cond. Smart Town Apt 2, Bl 8. CEP: 69099-000"),
    Order(lanny: lannies[1], date: "30/09", time: "17:00", duration: "4h", address: "Rua Pará, 476 - Vieiralves, Cond. Smart Town Apt 2, Bl 8. CEP: 69099-000"),
    Order(lanny: lannies[0], date: "23/09", time: "08:00", duration: "4h", address: "Rua Pará, 476 - Vieiralves, Cond. Smart Town Apt 2, Bl 8. CEP: 69099-000"),
  ];
}
