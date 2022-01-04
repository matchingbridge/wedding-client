import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/auth_service.dart';
import 'package:wedding/services/mobile/user_service.dart';
import 'package:wedding/widgets/mobile/components/select.dart';

class UserPageState {
  User? user;
  Detail? detail;
  UserPageState({this.user, this.detail});
  UserPageState copyWith({User? user, Detail? detail}) {
    return UserPageState(user: user, detail: detail);
  }
}

class UserPageBloc extends Cubit<UserPageState> {
  UserPageBloc(String userID) : super(UserPageState()) {
    Future.wait([getUser(userID), getDetail(userID)]);
  }

  Future<void> getUser(String userID) async {
    final user = await UserService.getPartner(userID);
    emit(state.copyWith(user: user));
  }

  Future<void> getDetail(String userID) async {
    // final detail = await DetailService.
  }
}

class UserPage extends StatelessWidget {
  final String userID;
  const UserPage({Key? key, required this.userID}) : super(key: key);

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

  Widget buildMedia(User user) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < 4) {
          final bucket = ['face1', 'face2', 'body1', 'body2'][index];
          final image = [user.face1, user.face2, user.body1, user.body2][index];
          return Image.network(
            'https://wedding-profile.s3.ap-northeast-2.amazonaws.com/dev/$bucket/$image',
            headers: {HttpHeaders.authorizationHeader: AuthService.accessToken},
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
              );
            },
          );
        } else {
          return VideoPlayer(
            VideoPlayerController.network(
              'https://wedding-profile.s3.ap-northeast-2.amazonaws.com/dev/video/${user.video}',
            ),
          );
        }
      },
      itemCount: 5,
      physics: const PageScrollPhysics(),
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildBackButton(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Positioned(
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
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 10,
          ),
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 10,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: BlocBuilder<UserPageBloc, UserPageState>(
              builder: (context, state) {
                final user = state.user;
                if (user == null) return const SizedBox();
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          child: buildMedia(user),
                          height: 480,
                        ),
                        buildBackButton(context),
                        buildIndicator(),
                      ],
                    ),
                    Padding(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                                  const SizedBox(width: 8),
                                  Text('${user.age}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 8),
                                  Text(user.gender == Gender.male ? '남' : '여'),
                                ],
                              ),
                              Container(
                                child: Text(user.job.literal, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: secondaryColor),
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          const SizedBox(height: 8),
                          Text(user.introduction),
                          Divider(color: inactiveColor, height: 32),
                          const Text('성격', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                          const SizedBox(height: 8),
                          WeddingSelect<Character>(
                            children: Character.values,
                            selected: [user.character],
                            labelBuilder: (character) => character.literal,
                          ),
                          const SizedBox(height: 20),
                          const Text('체형', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                          const SizedBox(height: 8),
                          WeddingSelect<BodyType>(
                            children: BodyType.values,
                            selected: [user.bodyType],
                            labelBuilder: (bodyType) => bodyType.male,
                          ),
                          const SizedBox(height: 20),
                          buildRow('생일', '${user.birthday.year}년 ${user.birthday.month}월 ${user.birthday.day}일'),
                          const SizedBox(height: 20),
                          buildRow('결혼 여부', user.marriage > 0 ? '${user.marriage}회' : '미혼'),
                          const SizedBox(height: 20),
                          buildRow('장거리 가능 여부', user.distance ? '가능' : '불가능'),
                          const SizedBox(height: 20),
                          buildRow('주소', user.area.literal),
                          const SizedBox(height: 20),
                          buildRow('직업', user.job.literal),
                          const SizedBox(height: 20),
                          buildRow('연봉', user.salary.literal),
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
                );
              },
              buildWhen: (previous, current) {
                return previous.user != current.user;
              },
            ),
            physics: const ClampingScrollPhysics(),
          ),
        ),
        create: (_) => UserPageBloc(userID));
  }
}
