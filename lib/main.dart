import 'package:flutter/material.dart';
import 'package:wedding/widgets/splash_page.dart';

void main() {
  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding',
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: SplashPage.widget(),
    );
  }
}
