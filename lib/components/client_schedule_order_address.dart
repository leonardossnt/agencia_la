import 'package:agencia_la/colors.dart';
import 'package:agencia_la/components/navigate_back.dart';
import 'package:agencia_la/components/title.dart';
import 'package:flutter/material.dart';

class ClientScheduleOrderAddress extends StatelessWidget {
  const ClientScheduleOrderAddress({Key? key, required this.args}) : super(key: key);
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
        _orderAddressField(),
        SizedBox(height: 16),
        _orderAddressConfirmButton(),
        SizedBox(height: 16),
      ],
    );
  }

  _orderAddressField() {
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
            controller: _address,
            keyboardType: TextInputType.streetAddress,
            maxLines: null,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              prefixIconColor: AgenciaLaColors.secondary,
              border: InputBorder.none,
              hintText: 'Endereço',
            ),
          ),
        ),
      ),
    );
  }

  _orderAddressConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ElevatedButton(
        onPressed: () {},
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
          "Continuar para crianças",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
