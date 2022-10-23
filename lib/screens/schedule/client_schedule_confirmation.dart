import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/child.dart';
import 'package:agencia_la/model/order.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:agencia_la/screens/components/navigate_back.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:agencia_la/screens/schedule/schedule_confirm_button.dart';
import 'package:flutter/material.dart';

class ClientScheduleConfirmation extends StatelessWidget {
  const ClientScheduleConfirmation({Key? key, required this.args})
      : super(key: key);
  final Map<String, String> args;

  @override
  Widget build(BuildContext context) {
    var child = Child(
        name: args['child_name'] ?? '',
        birthday: args['child_birthday'] ?? '',
        gender: args['child_gender'] ?? '',
        kinship: args['child_kinship'] ?? '',
        comments: args['child_comments'] ?? '');

    var order = Order(
        child: child,
        date: args['date'] ?? '',
        time: args['startTime'] ?? '',
        duration: args['duration'] ?? '',
        address: args['address'] ?? '',
        status: 'processing',
    );

    return Scaffold(
      backgroundColor: AgenciaLaColors.background,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60),
                  NavigateBack(title: 'Informações da criança'),
                  SizedBox(height: 12),
                  ScreenTitle("Revisar pedido"),
                  SizedBox(height: 36),
                  OrderReview(args: args),
                  scheduleConfirmButton(
                      text: 'Solicitar Lanny',
                      onPressed: (){},
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class OrderReview extends StatelessWidget {
  const OrderReview({Key? key, required this.args}) : super(key: key);
  final Map<String, String> args;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    args.forEach((key, value) {
      list.add(Row(
        children: [Text(key), Text(value)],
      ));
    });

    return Column(children: list);
  }
}
