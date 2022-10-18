import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/order.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/network/database.dart';
import 'package:flutter/material.dart';
import 'title.dart';

class FinishedOrders extends StatefulWidget {
  const FinishedOrders({Key? key}) : super(key: key);

  @override
  State<FinishedOrders> createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SectionTitle("Finalizados"),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FinishedOrderList(),
        ),
      ],
    );
  }
}

class FinishedOrderList extends StatefulWidget {
  const FinishedOrderList({Key? key}) : super(key: key);

  @override
  State<FinishedOrderList> createState() => _FinishedOrderListState();
}

class _FinishedOrderListState extends State<FinishedOrderList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database.getFinishedOrdersByClient(Auth.getCurrentUser()?.uid ?? ""),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print("finishedOrders snapshot?");
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          print("finishedOrders is COOL!");
          var finishedOrders = snapshot.data as List<Order>;
          var orderList = <Widget>[];
          for(Order order in finishedOrders) {
            orderList.add(FinishedOrderCard(order: order));
          }
          return Column(children: orderList);
        } else {
          print("finishedOrders is not rendered :(");
          return Column(
            children: const [
              SizedBox(height: 18),
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}

class FinishedOrderCard extends StatelessWidget {
  final Order order;
  const FinishedOrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        color: AgenciaLaColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                backgroundColor: AgenciaLaColors.inputBackground,
                backgroundImage: AssetImage('assets/images/logo_teal.png'),
                foregroundImage: NetworkImage(order.lanny.picture),
                radius: 40,
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    order.date,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AgenciaLaColors.foreground,
                    ),
                  ),
                  Text(
                    "Lanny ${order.lanny.name}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AgenciaLaColors.foreground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
