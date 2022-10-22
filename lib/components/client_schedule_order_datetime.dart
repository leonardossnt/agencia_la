import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/client_schedule_order_address.dart';
import 'package:agencia_la/components/navigate_back.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
        const SectionTitle("Escolha os dias"),
        _orderDatePicker(),
        SizedBox(height: 8),
        const SectionTitle("Defina o horário"),
        _orderTimePicker(),
        SizedBox(height: 16),
        _orderDateTimeConfirmButton(),
        SizedBox(height: 16),
      ],
    );
  }

  _orderDatePicker() {
    MaskTextInputFormatter maskFormatterDate = MaskTextInputFormatter(
        mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      child: Card(
        elevation: 4,
        color: AgenciaLaColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: Size.infinite.width,
          padding: EdgeInsets.all(16),
          child: TextFormField(
            controller: _date,
            inputFormatters: [maskFormatterDate],
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.calendar_month),
                prefixIconColor: AgenciaLaColors.secondary,
                border: InputBorder.none,
                hintText: 'Dia',
                contentPadding: EdgeInsets.only(left: 30, top: 15),
            ),
          ),
        ),
      ),
    );
  }

  _orderTimePicker() {
    MaskTextInputFormatter maskFormatterTime = MaskTextInputFormatter(
        mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      child: Card(
        elevation: 4,
        color: AgenciaLaColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: Size.infinite.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _startTime,
                inputFormatters: [maskFormatterTime],
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.access_time),
                  prefixIconColor: AgenciaLaColors.secondary,
                  border: InputBorder.none,
                  hintText: 'Horário inicial',
                  contentPadding: EdgeInsets.only(left: 30, top: 15),
                ),
              ),
              TextFormField(
                controller: _endTime,
                inputFormatters: [maskFormatterTime],
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.access_time),
                  prefixIconColor: AgenciaLaColors.secondary,
                  border: InputBorder.none,
                  hintText: 'Horário final',
                  contentPadding: EdgeInsets.only(left: 30, top: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _orderDateTimeConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ClientScheduleOrderAddress(args: <String, String> {
                  'date': _date.text,
                  'startTime': _startTime.text,
                  'endTime': _endTime.text
                })
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AgenciaLaColors.primary,
          foregroundColor: AgenciaLaColors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: const Text(
          "Continuar para local",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
