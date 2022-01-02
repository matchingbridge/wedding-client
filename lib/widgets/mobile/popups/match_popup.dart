import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';

class MatchPopup extends StatelessWidget {
  const MatchPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red,
          ),
          height: 240,
          width: 130,
        ),
        const SizedBox(height: 8),
        const Text('LILY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
        const SizedBox(height: 8),
        const Text('매칭이 이루어졌습니다.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
        const SizedBox(height: 16),
        TextButton(
          child: const Text('연락처 보기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
          onPressed: () {}, 
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(secondaryColor),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

}