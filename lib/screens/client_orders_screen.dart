import 'package:agencia_la/components/screen_title.dart';
import 'package:flutter/material.dart';

class ClientOrdersScreen extends StatelessWidget {
  const ClientOrdersScreen({Key? key}) : super(key: key);

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
                ScreenTitle("Meus Pedidos"),
                SizedBox(height: 84),
                // OngoingOrders(),
                SizedBox(height: 48),
                // FinishedOrders(),
                SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
