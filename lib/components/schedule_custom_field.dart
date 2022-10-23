import 'package:agencia_la/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

scheduleCustomField({
  required String hintText,
  required TextEditingController controller,
  required Icon icon,
  TextInputType keyboardType = TextInputType.name,
  bool dateFormatter = false,
  bool timeFormatter = false,
  bool isMultiLine = false,
}) {
  MaskTextInputFormatter maskFormatterDate = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  MaskTextInputFormatter maskFormatterTime =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  List<TextInputFormatter> inputFormatters = [];

  if (dateFormatter) {
    inputFormatters.add(maskFormatterDate);
  }
  if (timeFormatter) {
    inputFormatters.add(maskFormatterTime);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
    child: Card(
      elevation: 4,
      color: AgenciaLaColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: Size.infinite.width,
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLines: isMultiLine ? null : 1,
          decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: AgenciaLaColors.secondary,
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    ),
  );
}
