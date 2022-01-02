import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';

class WeddingTextField extends StatelessWidget {
  final Color? backgroundColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hint;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final double top;
  final double bottom;
  final Widget? postfix;
  const WeddingTextField(
    this.hint, {
    Key? key,
    this.backgroundColor,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    this.top = 8,
    this.bottom = 20,
    this.postfix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = TextField(
      controller: controller,
      decoration: InputDecoration.collapsed(hintText: hint, hintStyle: TextStyle(color: hintColor, fontSize: 14, fontWeight: FontWeight.w500)),
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: obscureText,
    );
    if (postfix != null) {
      child = Row(
        children: [
          Flexible(child: child),
          postfix!,
        ],
      );
    }
    return Container(
      child: child,
      decoration: BoxDecoration(border: Border.all(color: textFieldColor), borderRadius: BorderRadius.circular(8), color: backgroundColor),
      margin: EdgeInsets.only(top: top, bottom: bottom),
      padding: const EdgeInsets.all(12),
    );
  }
}
