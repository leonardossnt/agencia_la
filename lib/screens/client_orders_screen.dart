import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/finished_orders.dart';
import 'package:agencia_la/components/ongoing_order.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';

class ClientOrdersScreen extends StatelessWidget {
  const ClientOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Stack(children: [
          SingleChildScrollView(
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
          ),
          const OrderLannyFloatingButton(),
        ]);
      },
    );
  }
}

class OrderLannyFloatingButton extends StatelessWidget {
  const OrderLannyFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AgenciaLaColors.primary,
          foregroundColor: AgenciaLaColors.onPrimary,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: const Text("Solicitar Lanny", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
