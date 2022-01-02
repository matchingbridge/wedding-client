import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/pages/signin_page.dart';
import 'package:wedding/widgets/splash_page.dart';

class SplashPageState {}

class SplashPageBloc extends Cubit<SplashPageState> {
  SplashPageBloc() : super(SplashPageState());

  void initialize() {
    // TODO: check auth
  }
}

class SplashPageMobile extends SplashPage {
  const SplashPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Center(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 2),
                Text('본격 맞선 성공 프로젝트', style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w100)),
                Text('매칭 브릿지', style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w400)),
                GestureDetector(
                  child: Text('go'),
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage())),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )),
      create: (_) => SplashPageBloc(),
    );
  }
}

SplashPage getSplashPage() => const SplashPageMobile();
