import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/address_service.dart';
import 'package:wedding/widgets/mobile/components/date.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';
import 'package:wedding/widgets/mobile/components/select.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';
import 'package:wedding/widgets/mobile/popups/company_popup.dart';
import 'package:wedding/widgets/mobile/popups/employment_popup.dart';
import 'package:wedding/widgets/mobile/popups/job_popup.dart';
import 'package:wedding/widgets/mobile/popups/major_popup.dart';
import 'package:wedding/widgets/mobile/popups/scholar_popup.dart';
import 'package:wedding/widgets/mobile/popups/school_popup.dart';
import 'package:wedding/widgets/mobile/popups/search_address_popup.dart';

class ProfilePageState {
  User user;
  String videoThumbnail;

  ProfilePageState({required this.user, this.videoThumbnail = ''});

  ProfilePageState copyWith({
    User? user,
    String? videoThumbnail,
  }) {
    return ProfilePageState(
      user: user ?? this.user,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
    );
  }

  bool get isReady {
    return true;
  }
}

class ProfilePageBloc extends Cubit<ProfilePageState> {
  ProfilePageBloc({required User user}) : super(ProfilePageState(user: user));

  void update({
    String? face1,
    String? face2,
    String? body1,
    String? body2,
    String? video,
    String? introduction,
    Area? area,
    String? address,
    String? detail,
    Gender? gender,
    YMD? birthday,
    int? marriage,
    int? height,
    int? weight,
    bool? smoke,
    bool? drink,
    Religion? religion,
    BodyType? bodyType,
    Character? character,
    Scholar? scholar,
    String? school,
    String? major,
    Job? job,
    String? company,
    String? workplace,
    Employment? employment,
    Salary? salary,
    bool? distance,
    YM? period,
    List<Character>? partnerCharacters,
    String? vehicle,
    String? videoThumbnail,
  }) {
    emit(state.copyWith(
      user: state.user.copyWith(
        face1: face1,
        face2: face2,
        body1: body1,
        body2: body2,
        video: video,
        introduction: introduction,
        area: area,
        address: address,
        detail: detail,
        gender: gender,
        birthday: birthday,
        marriage: marriage,
        height: height,
        weight: weight,
        smoke: smoke,
        drink: drink,
        religion: religion,
        bodyType: bodyType,
        character: character,
        scholar: scholar,
        school: school,
        major: major,
        job: job,
        company: company,
        workplace: workplace,
        employment: employment,
        salary: salary,
        distance: distance,
        period: period,
        partnerCharacters: partnerCharacters,
        vehicle: vehicle,
      ),
      videoThumbnail: videoThumbnail,
    ));
  }

  Future<List<Address>> searchAddress(String keyword) async {
    final result = await AddressService.getAddress(keyword);
    return result;
  }
}

class ProfilePage extends StatelessWidget {
  final User user;
  final void Function(User user)? onButtonDown;
  const ProfilePage({Key? key, required this.user, this.onButtonDown}) : super(key: key);

  Widget buildError() {
    return Container(
      child: Icon(
        Icons.add,
        color: textColor,
        size: 28,
      ),
      color: thumbnailColor,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget buildThumbnail(String label, String Function(ProfilePageState) image, bool Function(ProfilePageState, ProfilePageState) buildWhen,
      void Function(BuildContext, String) onSelect) {
    return Column(
      children: [
        Flexible(
          child: AspectRatio(
            aspectRatio: 1,
            child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
              builder: (context, state) {
                return GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image(state).isEmpty
                        ? buildError()
                        : Image.file(
                            File(image(state)),
                            errorBuilder: (context, error, stackTrace) => buildError(),
                            fit: BoxFit.cover,
                          ),
                  ),
                  onTap: () async {
                    String? path;
                    if (label == '동영상') {
                      path = (await ImagePicker().pickVideo(source: ImageSource.gallery))?.path;
                    } else {
                      path = (await ImagePicker().pickImage(source: ImageSource.gallery))?.path;
                    }
                    if (path == null) return;
                    onSelect(context, path);
                  },
                );
              },
              buildWhen: buildWhen,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(label, style: TextStyle(color: textColor))
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildIntroduction() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        final introductionController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.introduction);
        introductionController.addListener(() {
          context.read<ProfilePageBloc>().update(introduction: introductionController.text);
        });
        return WeddingTextField('입력해주세요', controller: introductionController, maxLength: 200, maxLines: 5);
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildAddress() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        final keywordController = TextEditingController();
        final addressController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.address);
        addressController.addListener(() {
          context.read<ProfilePageBloc>().update(address: addressController.text);
        });
        final detailController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.detail);
        detailController.addListener(() {
          context.read<ProfilePageBloc>().update(detail: detailController.text);
        });
        return Column(
          children: [
            WeddingTextField(
              '우편번호 검색',
              bottom: 0,
              controller: keywordController,
              postfix: GestureDetector(
                child: const Text(
                  '검색',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () async {
                  final addresses = await context.read<ProfilePageBloc>().searchAddress(keywordController.text);
                  final address = await showDialog<Address>(
                    context: context,
                    builder: (context) => Dialog(child: SearchAddressPopup(addresses: addresses)),
                  );
                  if (address == null) return;
                  context.read<ProfilePageBloc>().update(area: address.area, address: address.address);
                  addressController.text = address.address;
                },
              ),
            ),
            WeddingTextField(
              '주소',
              bottom: 0,
              controller: addressController,
            ),
            WeddingTextField(
              '상세주소입력',
              controller: detailController,
            ),
          ],
        );
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildGender() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingRadio<Gender>(
          children: Gender.values,
          labelBuilder: (gender) => gender.literal,
          selected: state.user.gender,
          onTap: (gender) {
            context.read<ProfilePageBloc>().update(gender: gender);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.gender != current.user.gender;
      },
    );
  }

  Widget buildBirthday() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingDate(
          value: state.user.birthday,
          withDay: true,
          onChanged: (value) {
            if (value.length == 8) {
              context.read<ProfilePageBloc>().update(birthday: YMD.fromString(value));
            }
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.birthday != current.user.birthday;
      },
    );
  }

  Widget buildMarriage() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        Widget widget = WeddingRadio<bool>(
          children: const [true, false],
          labelBuilder: (marriage) => marriage ? '돌싱' : '미혼',
          selected: 0 < state.user.marriage,
          onTap: (marriage) {
            context.read<ProfilePageBloc>().update(marriage: marriage ? 1 : 0);
          },
        );
        if (0 < state.user.marriage) {
          widget = Column(
            children: [
              widget,
              WeddingRadio<int>(
                children: const [1, 2, 3],
                labelBuilder: (marriage) {
                  switch (marriage) {
                    case 1:
                      return '1회';
                    case 2:
                      return '2회';
                    default:
                      return '3회 이상';
                  }
                },
                selected: state.user.marriage,
                onTap: (marriage) {
                  context.read<ProfilePageBloc>().update(marriage: marriage);
                },
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          );
        }
        return widget;
      },
      buildWhen: (previous, current) {
        return previous.user.marriage != current.user.marriage;
      },
    );
  }

  Widget buildHeight() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        final heightController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.height.toString());
        heightController.addListener(() {
          context.read<ProfilePageBloc>().update(height: int.tryParse(heightController.text) ?? 0);
        });
        return WeddingTextField(
          '입력해주세요',
          controller: heightController,
          keyboardType: TextInputType.number,
          postfix: Text(
            'cm',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildWeight() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        final weightController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.weight.toString());
        weightController.addListener(() {
          context.read<ProfilePageBloc>().update(weight: int.tryParse(weightController.text) ?? 0);
        });
        return WeddingTextField(
          '입력해주세요',
          controller: weightController,
          keyboardType: TextInputType.number,
          postfix: Text(
            'kg',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildSmoke() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingRadio<bool>(
          children: const [true, false],
          labelBuilder: (smoke) => smoke ? '흡연' : '비흡연',
          selected: state.user.smoke,
          onTap: (smoke) {
            context.read<ProfilePageBloc>().update(smoke: smoke);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.smoke != current.user.smoke;
      },
    );
  }

  Widget buildDrink() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingRadio<bool>(
          children: const [true, false],
          labelBuilder: (drink) => drink ? '음주' : '비음주',
          selected: state.user.drink,
          onTap: (drink) {
            context.read<ProfilePageBloc>().update(drink: drink);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.drink != current.user.drink;
      },
    );
  }

  Widget buildReligion() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingRadio<Religion>(
          children: Religion.values,
          labelBuilder: (religion) => religion.literal,
          selected: state.user.religion,
          onTap: (religion) {
            context.read<ProfilePageBloc>().update(religion: religion);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.religion != current.user.religion;
      },
    );
  }

  Widget buildBodyType() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingSelect<BodyType>(
          children: BodyType.values,
          selected: [state.user.bodyType],
          labelBuilder: (bodyType) {
            switch (state.user.gender) {
              case Gender.male:
                return bodyType.male;
              case Gender.female:
                return bodyType.female;
            }
          },
          onTap: (bodyType) {
            context.read<ProfilePageBloc>().update(bodyType: bodyType);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.bodyType != current.user.bodyType || previous.user.gender != current.user.gender;
      },
    );
  }

  Widget buildCharacter() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingSelect<Character>(
          children: Character.values,
          selected: [state.user.character],
          labelBuilder: (character) => character.literal,
          onTap: (character) {
            context.read<ProfilePageBloc>().update(character: character);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.character != current.user.character;
      },
    );
  }

  Widget buildScholar() {
    return Column(
      children: [
        Row(
          children: [
            const Text('학력', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
            BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
              return TextButton(
                child: const Text('입력', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                onPressed: () async {
                  final scholar = await showDialog(
                    context: context,
                    builder: (context) => Dialog(child: ScholarPopup(scholar: state.user.scholar)),
                  );
                  if (scholar == null) return;
                  final school = await showDialog(context: context, builder: (context) => const Dialog(child: SchoolPopup()));
                  if (school == null) return;
                  final major = await showDialog(context: context, builder: (context) => const Dialog(child: MajorPopup()));
                  context.read<ProfilePageBloc>().update(
                        scholar: scholar,
                        school: school,
                        major: major,
                      );
                },
              );
            }, buildWhen: (previous, current) {
              return false;
            })
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            return Text('${state.user.scholar.literal} ${state.user.school} ${state.user.major}');
          },
          buildWhen: (previous, current) {
            return previous.user.scholar != current.user.scholar ||
                previous.user.school != current.user.school ||
                previous.user.major != current.user.major;
          },
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildJob() {
    return Column(
      children: [
        Row(
          children: [
            const Text('직장', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
            BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
              return TextButton(
                child: const Text('입력', style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                onPressed: () async {
                  final job = await showDialog<Job>(
                    context: context,
                    builder: (context) => const Dialog(child: JobPopup()),
                  );
                  if (job == null) return;
                  final companyMap = await showDialog(context: context, builder: (context) => const Dialog(child: CompanyPopup()));
                  if (companyMap == null) return;
                  final employment = await showDialog(context: context, builder: (context) => const Dialog(child: EmploymentPopup()));
                  context.read<ProfilePageBloc>().update(
                        job: job,
                        company: companyMap['company'],
                        workplace: companyMap['workplace'],
                        employment: employment,
                      );
                },
              );
            }, buildWhen: (previous, current) {
              return false;
            })
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            return Text('${state.user.job.literal} ${state.user.company} ${state.user.workplace} ${state.user.employment.literal}');
          },
          buildWhen: (previous, current) {
            return previous.user.job != current.user.job ||
                previous.user.company != current.user.company ||
                previous.user.workplace != current.user.workplace ||
                previous.user.employment != current.user.employment;
          },
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildDistance() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingRadio<bool>(
          children: const [true, false],
          labelBuilder: (distance) => distance ? '가능' : '불가능',
          selected: state.user.distance,
          onTap: (distance) {
            context.read<ProfilePageBloc>().update(distance: distance);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.distance != current.user.distance;
      },
    );
  }

  Widget buildPeriod() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingDate(
          withDay: false,
          value: state.user.period.withDay(0),
          onChanged: (value) {
            if (value.length == 6) {
              context.read<ProfilePageBloc>().update(period: YM.fromString(value));
            }
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.period != current.user.period;
      },
    );
  }

  Widget buildPartner() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return WeddingSelect<Character>(
          children: Character.values,
          selected: state.user.partnerCharacters,
          labelBuilder: (character) => character.literal,
          onTap: (character) {
            final partnerCharacters = List<Character>.from(state.user.partnerCharacters);
            if (partnerCharacters.contains(character)) {
              partnerCharacters.remove(character);
            } else {
              partnerCharacters.add(character);
            }
            context.read<ProfilePageBloc>().update(partnerCharacters: partnerCharacters);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.user.partnerCharacters != current.user.partnerCharacters;
      },
    );
  }

  Widget buildVehicles() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        final vehicleController = TextEditingController(text: context.read<ProfilePageBloc>().state.user.vehicle);
        vehicleController.addListener(() {
          context.read<ProfilePageBloc>().update(vehicle: vehicleController.text);
        });
        return WeddingTextField('차량명 입력', controller: vehicleController);
      },
      buildWhen: (previous, current) {
        return false;
      },
    );
  }

  Widget buildButton() {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return TextButton(
          child: const Text('가입 완료', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
          onPressed: state.isReady ? () => onButtonDown?.call(context.read<ProfilePageBloc>().state.user) : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return inactiveColor;
              } else {
                return secondaryColor;
              }
            }),
            padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        );
      },
      buildWhen: (previous, current) {
        return previous.isReady != current.isReady;
      },
    );
  }

  Widget buildProfileForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('나의 프로필', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('나의 기본 프로필을 등록해 주세요.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 32),
          const Text('나의 프로필', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          GridView.extent(
            childAspectRatio: 0.9,
            children: [
              buildThumbnail(
                '얼굴 정면',
                (state) => state.user.face1,
                (previous, current) => previous.user.face1 != current.user.face1,
                (context, image) => context.read<ProfilePageBloc>().update(face1: image),
              ),
              buildThumbnail(
                '얼굴 정면',
                (state) => state.user.face2,
                (previous, current) => previous.user.face2 != current.user.face2,
                (context, image) => context.read<ProfilePageBloc>().update(face2: image),
              ),
              buildThumbnail(
                '전신',
                (state) => state.user.body1,
                (previous, current) => previous.user.body1 != current.user.body1,
                (context, image) => context.read<ProfilePageBloc>().update(body1: image),
              ),
              buildThumbnail(
                '전신',
                (state) => state.user.body2,
                (previous, current) => previous.user.body2 != current.user.body2,
                (context, image) => context.read<ProfilePageBloc>().update(body2: image),
              ),
              buildThumbnail(
                '동영상',
                (state) => state.videoThumbnail,
                (previous, current) => previous.videoThumbnail != current.videoThumbnail,
                (context, video) async {
                  final path = await VideoThumbnail.thumbnailFile(video: video);
                  context.read<ProfilePageBloc>().update(video: video, videoThumbnail: path);
                },
              ),
            ],
            maxCrossAxisExtent: 150,
            mainAxisSpacing: 20,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          const SizedBox(height: 20),
          const Text('나의 소개', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildIntroduction(),
          const Text('주소', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildAddress(),
          const Text('성별', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildGender(),
          const SizedBox(height: 20),
          const Text('생년월일', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          buildBirthday(),
          const SizedBox(height: 20),
          const Text('결혼여부', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildMarriage(),
          const SizedBox(height: 20),
          const Text('키', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildHeight(),
          const Text('몸무게', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          buildWeight(),
          const Text('흡연', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildSmoke(),
          const SizedBox(height: 20),
          const Text('음주', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildDrink(),
          const SizedBox(height: 20),
          const Text('종교', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildReligion(),
          const SizedBox(height: 20),
          const Text('체형', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildBodyType(),
          const SizedBox(height: 20),
          const Text('성격', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCharacter(),
          const SizedBox(height: 20),
          buildScholar(),
          buildJob(),
          const SizedBox(height: 20),
          const Text('장거리 가능여부', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildDistance(),
          const SizedBox(height: 20),
          const Text('희망결혼 시기', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          buildPeriod(),
          const SizedBox(height: 20),
          const Text('원하는 이성상', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          buildPartner(),
          const SizedBox(height: 20),
          const Text('차량소유여부', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildVehicles(),
          buildButton(),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
      padding: const EdgeInsets.all(20),
      physics: const ClampingScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: 1,
              backgroundColor: inactiveColor,
              color: secondaryColor,
            ),
            Flexible(child: buildProfileForm(context)),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      create: (context) => ProfilePageBloc(user: user),
    );
  }
}
