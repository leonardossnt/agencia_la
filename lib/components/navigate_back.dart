import 'package:agencia_la/colors.dart';
import 'package:flutter/material.dart';

class NavigateBack extends StatelessWidget {
  const NavigateBack(
      {Key? key, required this.title, this.color = AgenciaLaColors.primary})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              Icons.arrow_back_ios,
              color: color,
              size: 24,
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 18, color: color, fontWeight: FontWeight.w300))
          ]),
        ),
      ),
    );
  }
}
