import 'package:flutter/material.dart';
import 'package:wedding/widgets/splash_page_stub.dart'
    if (dart.library.io) 'package:wedding/widgets/mobile/pages/splash_page.dart'
    if (dart.library.js) 'package:wedding/widgets/web/pages/splash_page.dart';

abstract class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Widget widget() => getSplashPage();
}
