import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/pages/guide_page.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 120),
                Image.asset(
                  'assets/images/logo.png',
                  scale: 8,
                ),
                const SizedBox(height: 12),
                const Text('가입신청이 완료 되었습니다', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                Text(
                  '매칭브릿지는 가입후 내부 심사를 걸쳐\n인증된 회원들만 승인하고 있습니다.',
                  style: TextStyle(color: hintColor, fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      '이용절차 구경하러 가기',
                      style: TextStyle(color: secondaryColor, decoration: TextDecoration.underline, fontSize: 12, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GuidePage()));
                    },
                  ),
                  TextButton(
                    child: const Text(
                      '로그인 화면으로 돌아가기',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(inactiveColor),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
              padding: const EdgeInsets.all(20),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        color: primaryColor,
      ),
    );
  }
}
