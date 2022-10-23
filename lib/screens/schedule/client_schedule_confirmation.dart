import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/child.dart';
import 'package:agencia_la/model/order.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/network/database.dart';
import 'package:agencia_la/screens/client_main_screen.dart';
import 'package:agencia_la/screens/components/navigate_back.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:agencia_la/screens/schedule/schedule_confirm_button.dart';
import 'package:flutter/material.dart';

class ClientScheduleConfirmation extends StatefulWidget {
  const ClientScheduleConfirmation({Key? key, required this.args})
      : super(key: key);
  final Map<String, String> args;

  @override
  State<ClientScheduleConfirmation> createState() => _ClientScheduleConfirmationState();
}

class _ClientScheduleConfirmationState extends State<ClientScheduleConfirmation> {
  bool isLoading = false;

  void action(Order order) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
    setState(() {
      isLoading = true;
    });
    await requestLanny(order);
    setState(() {
      isLoading = false;
    });
  }

  Future requestLanny(Order order) async {
      String userUid = Auth.getCurrentUser()?.uid ?? "";

      if (await Database.addOrder(userUid, order)) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ClientMainScreen()),
                (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Pedido adicionado com sucesso!")));
      } else {
        // TODO: handle possible exception
      }
    }

  @override
  Widget build(BuildContext context) {
    var child = Child(
        name: widget.args['child_name'] ?? '',
        birthday: widget.args['child_birthday'] ?? '',
        gender: widget.args['child_gender'] ?? '',
        kinship: widget.args['child_kinship'] ?? '',
        comments: widget.args['child_comments'] ?? '');

    var order = Order(
        child: child,
        date: widget.args['date'] ?? '',
        time: widget.args['startTime'] ?? '',
        duration: widget.args['duration'] ?? '',
        address: widget.args['address'] ?? '',
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
                  NavigateBack(title: 'Informações da criança', disabled: isLoading),
                  SizedBox(height: 12),
                  ScreenTitle("Revisar pedido"),
                  SizedBox(height: 36),
                  OrderReview(args: widget.args),
                  scheduleConfirmButton(
                      text: 'Solicitar Lanny',
                      onPressed: () => action(order),
                      isLoading: isLoading,
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
