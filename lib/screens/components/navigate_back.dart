import 'package:agencia_la/colors.dart';
import 'package:flutter/material.dart';

class NavigateBack extends StatelessWidget {
  const NavigateBack({Key? key,
      required this.title,
      this.color = AgenciaLaColors.primary,
      this.disabled = false}) : super(key: key);

  final String title;
  final Color color;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextButton(
          onPressed: disabled ? null : () => Navigator.pop(context),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.arrow_back_ios,
              color: disabled ? AgenciaLaColors.unselectedIcon : color,
              size: 24,
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    color: disabled ? AgenciaLaColors.unselectedIcon : color,
                    fontWeight: FontWeight.w300))
          ]),
        ),
      ),
    );
  }
}
