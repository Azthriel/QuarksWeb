import 'package:flutter/material.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: lenguaje,
      builder: (context, value, child) {
        return Container(
          color: color0,
          padding: const EdgeInsets.all(16),
          child: Text(
            footer(value),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
