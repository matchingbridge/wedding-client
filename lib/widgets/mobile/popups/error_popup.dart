import 'package:flutter/material.dart';

class ErrorPopup extends StatelessWidget {
  final String title;
  final String error;
  const ErrorPopup({Key? key, required this.title, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(error),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      padding: const EdgeInsets.all(20),
    );
  }
}
