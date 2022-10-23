import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/client_schedule_order_children.dart';
import 'package:agencia_la/components/navigate_back.dart';
import 'package:agencia_la/components/schedule_confirm_button.dart';
import 'package:agencia_la/components/schedule_custom_field.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';

class ClientScheduleOrderAddress extends StatelessWidget {
  const ClientScheduleOrderAddress({Key? key, required this.args})
      : super(key: key);
  final Map<String, String> args;

  @override
  Widget build(BuildContext context) {
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
                  NavigateBack(title: 'Escolha os dias'),
                  SizedBox(height: 12),
                  ScreenTitle("Solicite uma Lanny"),
                  SizedBox(height: 36),
                  OrderAddressForm(args: args),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class OrderAddressForm extends StatefulWidget {
  const OrderAddressForm({Key? key, required this.args}) : super(key: key);
  final Map<String, String> args;

  @override
  State<OrderAddressForm> createState() => _OrderAddressFormState();
}

class _OrderAddressFormState extends State<OrderAddressForm> {
  final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle("Informe o local"),
        SizedBox(height: 8),
        scheduleCustomField(
          hintText: 'Endereço',
          controller: _address,
          icon: Icon(Icons.location_on),
          keyboardType: TextInputType.streetAddress,
          isMultiLine: true,
        ),
        SizedBox(height: 8),
        scheduleConfirmButton(
          text: 'Continuar para crianças',
          onPressed: () {
            var args = {"address": _address.text};
            args.addAll(widget.args);

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      ClientScheduleOrderChildren(args: args)),
            );
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
