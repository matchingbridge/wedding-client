import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/widgets/mobile/pages/detail_page.dart';
import 'package:wedding/widgets/mobile/pages/guide_page.dart';
import 'package:wedding/widgets/mobile/pages/profile_page.dart';

class SettingPageState {}

class SettingPageBloc extends Cubit<SettingPageState> {
  SettingPageBloc() : super(SettingPageState());
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  Widget buildRow(String label, {Widget? widget, void Function()? onPressed}) {
    Widget postfix = IconButton(
      color: textColor,
      icon: const Icon(Icons.arrow_forward_ios),
      onPressed: onPressed ?? () {},
    );
    if (widget != null) {
      postfix = Row(children: [widget, postfix]);
    }
    return Row(
      children: [
        Text(label),
        postfix,
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Container(
                    color: secondaryColor,
                    height: 100,
                  ),
                  top: 0,
                  left: 0,
                  right: 0,
                ),
                Column(
                  children: [
                    const SizedBox(height: 68),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.orange),
                      height: 64,
                      width: 64,
                    ),
                    const SizedBox(height: 8),
                    const Text('김정아', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500)),
                    Text('1999년 1월 1일', style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Padding(
              child: Column(
                children: [
                  Text('프로필', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
                  buildRow('프로필', onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  user: User.profile(email: 'email', name: 'name', phone: 'phone'),
                                )));
                  }),
                  buildRow(
                    '상세 프로필',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(detail: Detail(detailID: 0))));
                    },
                    widget: Text(
                      '68% 완료',
                      style: TextStyle(color: secondaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text('기타', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
                  buildRow('공지사항', onPressed: () {}),
                  buildRow('지인피하기', onPressed: () {}),
                  buildRow('이용절차', onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GuidePage()));
                  }),
                  Text('기타', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
                  buildRow('불량 회원 신고', onPressed: () {}),
                  buildRow('자주 묻는 질문', onPressed: () {}),
                  buildRow('1:1 문의하기', onPressed: () {}),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              padding: const EdgeInsets.all(20),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        color: Colors.white,
      ),
      create: (context) => SettingPageBloc(),
    );
  }
}
