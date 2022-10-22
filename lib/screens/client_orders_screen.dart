import 'package:agencia_la/components/finished_orders.dart';
import 'package:agencia_la/components/ongoing_order.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';

class ClientOrdersScreen extends StatelessWidget {
  const ClientOrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/clientOrdersScreen';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                SizedBox(height: 120),
                ScreenTitle("Meus pedidos"),
                SizedBox(height: 36),
                OngoingOrders(),
                SizedBox(height: 48),
                FinishedOrders(),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
