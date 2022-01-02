import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/pages/chat_page.dart';
import 'package:wedding/widgets/mobile/pages/match_page.dart';

class HomePageState {
  double offset;
  HomePageState({
    this.offset = 0,
  });
  HomePageState copyWith({
    double? offset,
  }) {
    return HomePageState(offset: offset ?? this.offset);
  }
}

class HomePageBloc extends Cubit<HomePageState> {
  HomePageBloc() : super(HomePageState());

  var scrolling = false;

  void onUpdateScroll(ScaleUpdateDetails details, double maxOffset) {
    scrolling = true;
    final offset = (state.offset - details.focalPointDelta.dy).clamp(0.0, maxOffset);
    emit(state.copyWith(offset: offset));
  }

  Future<void> onEndScroll(ScaleEndDetails details, double threshold) async {
    final index = (state.offset / threshold).round();
    final offset = threshold * index;
    scrolling = false;
    while (state.offset != offset) {
      if (scrolling) return;
      var partialOffset = (offset - state.offset) * 0.1;
      if (partialOffset.abs() < 1) {
        emit(state.copyWith(offset: offset));
      } else {
        emit(state.copyWith(offset: state.offset + partialOffset));
      }
      await Future.delayed(const Duration(milliseconds: 16));
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget buildUser(BuildContext context, double height, Color color) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        height: height,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Container(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxScrollUp = constraints.maxHeight - 40;
              return BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  return GestureDetector(
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: homeColor.withOpacity((1.0 - (state.offset / (maxScrollUp * 3))).clamp(0.0, 1.0)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: SafeArea(
                            child: Text(
                              '오늘의 인연',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Text(
                                '마음에 드는 이성이 없으신가요?',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '주선자에게 원하는 조건의 이성을 직접 소개받을 수 있습니다.',
                                style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 24),
                              TextButton(
                                child: const Text(
                                  '소개 받기',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage()));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 4, horizontal: 24)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Positioned(
                          bottom: (state.offset - maxScrollUp * 2).clamp(0, maxScrollUp - 80),
                          left: 40 - (state.offset / maxScrollUp).clamp(0.0, 3.0) * 10,
                          right: 40 - (state.offset / maxScrollUp).clamp(0.0, 3.0) * 10,
                          child: buildUser(context, constraints.maxHeight - 120, Colors.red),
                        ),
                        Positioned(
                            bottom: (state.offset - maxScrollUp).clamp(0, maxScrollUp - 80) + 10,
                            left: 30 - (state.offset / maxScrollUp).clamp(0.0, 2.0) * 10,
                            right: 30 - (state.offset / maxScrollUp).clamp(0.0, 2.0) * 10,
                            child: buildUser(context, constraints.maxHeight - 120, Colors.orange)),
                        Positioned(
                          bottom: (state.offset).clamp(0, maxScrollUp - 80) + 20,
                          left: 20 - (state.offset / maxScrollUp).clamp(0.0, 1.0) * 10,
                          right: 20 - (state.offset / maxScrollUp).clamp(0.0, 1.0) * 10,
                          child: buildUser(context, constraints.maxHeight - 120, Colors.yellow),
                        ),
                      ],
                    ),
                    onScaleUpdate: (details) {
                      context.read<HomePageBloc>().onUpdateScroll(details, maxScrollUp * 3);
                    },
                    onScaleEnd: (details) {
                      context.read<HomePageBloc>().onEndScroll(details, maxScrollUp);
                    },
                  );
                },
                buildWhen: (previous, current) {
                  return previous.offset != current.offset;
                },
              );
            },
          ),
          color: primaryColor,
          padding: const EdgeInsets.only(bottom: 100),
        ),
        create: (_) => HomePageBloc());
  }
}
