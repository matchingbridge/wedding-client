import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';

class QuitChatPopup extends StatelessWidget {
  const QuitChatPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('정말 상담을 종료하고\n나가시겠습니까?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                child: const Text('나가기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                onPressed: () {
                  Navigator.pop(context, true);
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(inactiveColor),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                ),
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: TextButton(
                child: const Text('계속 상담하기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
                onPressed: () {
                  Navigator.pop(context, false);
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(secondaryColor),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                ),
              )
            )
          ],
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

}