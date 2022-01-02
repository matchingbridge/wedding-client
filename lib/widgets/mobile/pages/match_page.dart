import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/match_service.dart';
import 'package:wedding/widgets/mobile/components/select.dart';

class MatchPageState {
  List<Match> matched;
  List<Match> unmatched;

  MatchPageState({this.matched = const [], this.unmatched = const []});
}

class MatchPageBloc extends Cubit<MatchPageState> {
  MatchPageBloc() : super(MatchPageState()) {
    getMatch();
  }

  Future<void> getMatch() async {
    final matched = await MatchService.getMatched();
    final unmatched = await MatchService.getUnmatched();

    emit(MatchPageState(matched: matched, unmatched: unmatched));
  }
}

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  Widget buildRow(String label, String? content) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        ),
        if (content != null)
          Text(
            content,
            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        if (content == null)
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const Text('가입해주세요'),
          )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      child: BlocBuilder<MatchPageBloc, MatchPageState>(
                        builder: (context, state) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  state.matched[index].image(),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: [Colors.red, Colors.green, Colors.blue][index],
                                      width: MediaQuery.of(context).size.width,
                                    );
                                  },
                                ),
                              );
                            },
                            itemCount: state.matched.length,
                            physics: const PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                          );
                        },
                      ),
                      height: 480,
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: secondaryColor,
                            size: 10,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      bottom: 20,
                      left: 0,
                      right: 0,
                    )
                  ],
                ),
                Padding(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'name',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '30',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 8),
                              const Text('여'),
                            ],
                          ),
                          Container(
                            child: const Text(
                              '번역가',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: secondaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      const SizedBox(height: 8),
                      const Text('설명설명설명설명설명설명설명설명설명설명설명'),
                      Divider(color: inactiveColor, height: 32),
                      const Text('성격', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      WeddingSelect<Character>(
                        children: Character.values,
                        selected: const [],
                        labelBuilder: (character) => character.literal,
                        onTap: (character) {
                          // context.read<ProfilePageBloc>().update(character: character);
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('체형', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      WeddingSelect<BodyType>(
                        children: BodyType.values,
                        selected: const [],
                        labelBuilder: (bodyType) => bodyType.male,
                        onTap: (bodyType) {},
                      ),
                      const SizedBox(height: 20),
                      buildRow('생일', '1992년 3월 25일'),
                      const SizedBox(height: 20),
                      buildRow('결혼 여부', '3회 이상'),
                      const SizedBox(height: 20),
                      buildRow('장거리 가능 여부', '불가능'),
                      const SizedBox(height: 20),
                      buildRow('주소', '서울시 강남구'),
                      const SizedBox(height: 20),
                      buildRow('직업', null),
                      const SizedBox(height: 20),
                      buildRow('연봉', null),
                      const SizedBox(height: 20),
                      buildRow('학력', null),
                      const SizedBox(height: 20),
                      buildRow('차량', null),
                      const SizedBox(height: 20),
                      buildRow('키', null),
                      const SizedBox(height: 20),
                      buildRow('몸무게', null),
                      const SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              '숨겨진 정보를 보려면 멤버쉽 가입을 해주세요.',
                              style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                              child: const Text(
                                '가입하러 가기',
                                style: TextStyle(fontSize: 12, decoration: TextDecoration.underline),
                              ),
                              onPressed: () {},
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        decoration: BoxDecoration(border: Border.all(color: inactiveColor), borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                TextButton(
                  child: Row(
                    children: [
                      Image.asset('assets/images/center.png', scale: 4),
                      const Text(
                        ' 매칭 신청',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            physics: const ClampingScrollPhysics(),
          ),
        ),
        create: (_) => MatchPageBloc());
  }
}
