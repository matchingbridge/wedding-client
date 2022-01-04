import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/services/mobile/auth_service.dart';
import 'package:wedding/widgets/mobile/pages/root_page.dart';
import 'package:wedding/widgets/mobile/pages/signin_page.dart';
import 'package:wedding/widgets/splash_page.dart';

class SplashPageMobile extends SplashPage {
  const SplashPageMobile({Key? key}) : super(key: key);

  Future<String?> checkToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('access_token');
  }

  @override
  Widget build(BuildContext context) {
    Future.wait([
      checkToken(),
      Future.delayed(const Duration(seconds: 1)),
    ]).then((value) {
      final accessToken = value[0];
      if (accessToken == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
      } else {
        AuthService.accessToken = accessToken;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RootPage()));
      }
    });
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', scale: 2),
            Text('본격 맞선 성공 프로젝트', style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w100)),
            Text('매칭 브릿지', style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w400)),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

SplashPage getSplashPage() => const SplashPageMobile();
