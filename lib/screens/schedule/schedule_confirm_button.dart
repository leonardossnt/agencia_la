import 'package:agencia_la/colors.dart';
import 'package:flutter/material.dart';

scheduleConfirmButton({
  required String text,
  required Function onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 36),
    child: ElevatedButton(
      onPressed: () {
        onPressed();
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
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    ),
  );
}
