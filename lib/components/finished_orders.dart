import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/mock.dart';
import 'package:agencia_la/model/order.dart';
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
      children: [
        const SectionTitle("Finalizados"),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
    return Column(
      children: [
        FinishedOrderCard(order: Mock.orders[1]),
        FinishedOrderCard(order: Mock.orders[2]),
        FinishedOrderCard(order: Mock.orders[3]),
      ],
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
                backgroundColor: AgenciaLaColors.primary,
                backgroundImage: AssetImage(order.lanny.picture),
                radius: 32,
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    order.date,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AgenciaLaColors.foreground,
                    ),
                  ),
                  Text(
                    "Lanny ${order.lanny.name}",
                    style: TextStyle(
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
