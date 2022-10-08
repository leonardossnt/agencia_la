import 'package:flutter/material.dart';
import 'package:agencia_la/colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AgenciaLaColors.darkPrimary
                )
            )
        )
    );
  }
}
