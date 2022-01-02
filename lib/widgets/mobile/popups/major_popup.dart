import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';

class MajorPopup extends StatelessWidget {
  const MajorPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      child: Column(
        children: [
          WeddingTextField('전공 입력', controller: controller),
          TextButton(
            child: const Text('선택', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            style: TextButton.styleFrom(
              backgroundColor: secondaryColor,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      padding: const EdgeInsets.all(20),
    );
  }
}
