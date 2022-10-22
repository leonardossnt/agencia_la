import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/navigate_back.dart';
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
                  OrderDatePicker(),
                  SizedBox(height: 48),
                  OrderTimePicker(),
                  SizedBox(height: 16),
                  OrderDateTimeConfirmButton(),
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

class OrderDatePicker extends StatelessWidget {
  const OrderDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Escolha os dias"),
        Text("DatePicker aqui"),
      ],
    );
  }
}

class OrderTimePicker extends StatelessWidget {
  const OrderTimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Defina o horário"),
        Text("TimePicker aqui"),
      ],
    );
  }
}

class OrderDateTimeConfirmButton extends StatefulWidget {
  const OrderDateTimeConfirmButton({super.key});

  @override
  State<OrderDateTimeConfirmButton> createState() =>
      _OrderDateTimeConfirmButtonState();
}

class _OrderDateTimeConfirmButtonState
    extends State<OrderDateTimeConfirmButton> {
  void action() async {
    // TODO: action
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: AgenciaLaColors.primary,
          foregroundColor: AgenciaLaColors.onPrimary,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
