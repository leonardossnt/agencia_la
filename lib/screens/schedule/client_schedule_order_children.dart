import 'package:agencia_la/colors.dart';
import 'package:agencia_la/screens/components/navigate_back.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:agencia_la/screens/schedule/client_schedule_confirmation.dart';
import 'package:agencia_la/screens/schedule/schedule_confirm_button.dart';
import 'package:agencia_la/screens/schedule/schedule_custom_field.dart';
import 'package:flutter/material.dart';

class ClientScheduleOrderChildren extends StatelessWidget {
  const ClientScheduleOrderChildren({Key? key, required this.args})
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
                  NavigateBack(title: 'Informe o local'),
                  SizedBox(height: 12),
                  ScreenTitle("Solicite uma Lanny"),
                  SizedBox(height: 36),
                  OrderChildrenForm(args: args),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class OrderChildrenForm extends StatefulWidget {
  const OrderChildrenForm({Key? key, required this.args}) : super(key: key);
  final Map<String, String> args;

  @override
  State<OrderChildrenForm> createState() => _OrderChildrenFormState();
}

class _OrderChildrenFormState extends State<OrderChildrenForm> {
  final TextEditingController _childName = TextEditingController();
  final TextEditingController _childGender = TextEditingController();
  final TextEditingController _childBirthday = TextEditingController();
  final TextEditingController _childKinship = TextEditingController();
  final TextEditingController _childComments = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle("Informações da criança"),
        const SizedBox(height: 16),
        scheduleCustomField(
            hintText: 'Nome',
            controller: _childName,
            icon: const Icon(Icons.child_care)),
        scheduleCustomField(
            hintText: 'Gênero',
            controller: _childGender,
            icon: const Icon(Icons.question_mark)),
        scheduleCustomField(
            hintText: 'Data de nascimento',
            controller: _childBirthday,
            icon: const Icon(Icons.calendar_month),
            keyboardType: TextInputType.datetime,
            dateFormatter: true),
        scheduleCustomField(
            hintText: 'Grau de parentesco',
            controller: _childKinship,
            icon: const Icon(Icons.escalator_warning)),
        scheduleCustomField(
            hintText: 'Observações sobre a criança',
            controller: _childComments,
            icon: const Icon(Icons.medical_information_outlined),
            isMultiLine: true),
        const SizedBox(height: 16),
        scheduleConfirmButton(
            text: 'Solicitar Lanny',
            onPressed: () {
              var args = widget.args;

              args.addAll({
                "child_name": _childName.text,
                "child_birthday": _childBirthday.text,
                "child_gender": _childGender.text,
                "child_kinship": _childKinship.text,
                "child_comments": _childComments.text,
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        ClientScheduleConfirmation(args: args)),
              );
            }),
        const SizedBox(height: 16),
      ],
    );
  }
}
