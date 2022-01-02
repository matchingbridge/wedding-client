import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/models.dart';

class WeddingDate extends StatelessWidget {
  final bool withDay;
  final YMD? value;
  final void Function(String)? onChanged;
  const WeddingDate({
    Key? key,
    this.withDay = false,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = value?.toString();
    if (text != null) {
      text = text.substring(0, min(text.length, withDay ? 8 : 6));
    }
    return TextField(
      controller: TextEditingController(text: text),
      decoration: InputDecoration.collapsed(
        hintText: 'Y',
        hintStyle: TextStyle(color: textColor, decoration: TextDecoration.underline, letterSpacing: 4),
      ),
      style: const TextStyle(decoration: TextDecoration.underline, letterSpacing: 4),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if ((withDay ? 8 : 6) <= value.length) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          onChanged?.call(value);
        } else {
          onChanged?.call(value);
        }
      },
    );
  }
}
