import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/client_schedule_order_address.dart';
import 'package:agencia_la/components/navigate_back.dart';
import 'package:agencia_la/components/schedule_confirm_button.dart';
import 'package:agencia_la/components/schedule_custom_field.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';

class ClientScheduleOrderDateTime extends StatelessWidget {
  const ClientScheduleOrderDateTime({Key? key}) : super(key: key);

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
                children: const <Widget>[
                  SizedBox(height: 60),
                  NavigateBack(title: 'Pedidos'),
                  SizedBox(height: 12),
                  ScreenTitle("Solicite uma Lanny"),
                  SizedBox(height: 36),
                  OrderDateTimeForm(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class OrderDateTimeForm extends StatefulWidget {
  const OrderDateTimeForm({Key? key}) : super(key: key);

  @override
  State<OrderDateTimeForm> createState() => _OrderDateTimeFormState();
}

class _OrderDateTimeFormState extends State<OrderDateTimeForm> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle("Escolha o dia"),
        SizedBox(height: 8),
        scheduleCustomField(
            hintText: 'Dia',
            controller: _date,
            icon: const Icon(Icons.calendar_month),
            dateFormatter: true,
            keyboardType: TextInputType.datetime),
        SizedBox(height: 24),
        const SectionTitle("Defina o horário"),
        SizedBox(height: 16),
        scheduleCustomField(
            hintText: 'Horário de início',
            controller: _startTime,
            icon: Icon(Icons.access_time),
            keyboardType: TextInputType.datetime,
            timeFormatter: true),
        scheduleCustomField(
            hintText: 'Horário final',
            controller: _endTime,
            icon: Icon(Icons.access_time),
            keyboardType: TextInputType.datetime,
            timeFormatter: true),
        SizedBox(height: 16),
        scheduleConfirmButton(
            text: 'Continuar para local',
            onPressed: () {
              var args = {
                'date': _date.text,
                'startTime': _startTime.text,
                'endTime': _endTime.text
              };

              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        ClientScheduleOrderAddress(args: args)),
              );
            }),
        SizedBox(height: 16),
      ],
    );
  }
}
