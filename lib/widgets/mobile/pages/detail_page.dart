import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';
import 'package:wedding/widgets/mobile/components/select.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';

class DetailPageState {
  Detail detail;

  DetailPageState({required this.detail});

  DetailPageState copyWith({Detail? detail}) {
    return DetailPageState(detail: detail ?? this.detail);
  }
}

class DetailPageBloc extends Cubit<DetailPageState> {
  DetailPageBloc({required Detail detail}) : super(DetailPageState(detail: detail));
  void update({
    String? asset,
    bool? realEstate,
    String? familyCertificate,
    String? salaryCertificate,
    String? schoolCertificate,
    String? companyCertificate,
    String? vehicleCertificate,
    Range<int>? partnerAge,
    Range<int>? partnerHeight,
    School? partnerSchool,
    List<Job>? partnerJobs,
    Salary? partnerSalary,
    String? partnerAsset,
    Smoke? partnerSmoke,
    Drink? partnerDrink,
    Marriage? partnerMarriage,
    List<BodyType>? partnerBodies,
    String? partnerDescription,
  }) {
    emit(state.copyWith(
      detail: state.detail.copyWith(
        asset: asset,
        realEstate: realEstate,
        familyCertificate: familyCertificate,
        salaryCertificate: salaryCertificate,
        schoolCertificate: schoolCertificate,
        companyCertificate: companyCertificate,
        vehicleCertificate: vehicleCertificate,
        partnerAge: partnerAge,
        partnerHeight: partnerHeight,
        partnerSchool: partnerSchool,
        partnerJobs: partnerJobs,
        partnerSalary: partnerSalary,
        partnerAsset: partnerAsset,
        partnerSmoke: partnerSmoke,
        partnerDrink: partnerDrink,
        partnerMarriage: partnerMarriage,
        partnerBodies: partnerBodies,
        partnerDescription: partnerDescription,
      ),
    ));
  }
}

class DetailPage extends StatelessWidget {
  final Detail detail;
  const DetailPage({Key? key, required this.detail}) : super(key: key);

  Widget buildAsset() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        final assetController = TextEditingController();
        assetController.addListener(() {
          context.read<DetailPageBloc>().update(asset: assetController.text);
        });
        return WeddingTextField(
          '',
          controller: assetController,
          keyboardType: TextInputType.number,
          postfix: Text(
            '??????',
            style: TextStyle(color: hintColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.asset != current.detail.asset;
      },
    );
  }

  Widget buildRealEstate() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<bool?>(
          children: const [true, false],
          labelBuilder: (realEstate) {
            return realEstate == true ? '??????' : '?????????';
          },
          selected: state.detail.realEstate,
          onTap: (realEstate) {
            context.read<DetailPageBloc>().update(realEstate: realEstate);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.realEstate != current.detail.realEstate;
      },
    );
  }

  Widget buildCertificate(String? Function(DetailPageState) value, void Function(BuildContext) onTap) {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return Container(
          child: Row(
            children: [
              Text(value(state) ?? '?????????', style: TextStyle(color: hintColor, fontSize: 14, fontWeight: FontWeight.w500)),
              GestureDetector(
                child: Text(
                  '?????????',
                  style: TextStyle(
                    color: secondaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () => onTap(context),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          decoration: BoxDecoration(border: Border.all(color: textFieldColor), borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.familyCertificate != current.detail.familyCertificate;
      },
    );
  }

  Widget buildPartnerAge() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('${state.detail.partnerAge?.minimum ?? '-'}~${state.detail.partnerAge?.maximum ?? '-'}???'),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const SizedBox(height: 8),
            RangeSlider(
              min: 20.0,
              max: 100.0,
              values: RangeValues(state.detail.partnerAge?.minimum.toDouble() ?? 20.0, state.detail.partnerAge?.maximum.toDouble() ?? 100.0),
              onChanged: (partnerAge) {
                context.read<DetailPageBloc>().update(partnerAge: Range(x: partnerAge.start.toInt(), y: partnerAge.end.toInt()));
              },
              inactiveColor: thumbnailColor,
            ),
          ],
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerAge != current.detail.partnerAge;
      },
    );
  }

  Widget buildPartnerHeight() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Text('???', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('${state.detail.partnerHeight?.minimum ?? '-'}~${state.detail.partnerHeight?.maximum ?? '-'}cm'),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const SizedBox(height: 8),
            RangeSlider(
              min: 130.0,
              max: 200.0,
              values: RangeValues(state.detail.partnerHeight?.minimum.toDouble() ?? 130.0, state.detail.partnerHeight?.maximum.toDouble() ?? 200.0),
              onChanged: (partnerHeight) {
                context.read<DetailPageBloc>().update(partnerHeight: Range(x: partnerHeight.start.toInt(), y: partnerHeight.end.toInt()));
              },
              inactiveColor: thumbnailColor,
            ),
          ],
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerHeight != current.detail.partnerHeight;
      },
    );
  }

  Widget buildPartnerSchool() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<School?>(
          children: School.values,
          selected: state.detail.partnerSchool,
          labelBuilder: (school) => school?.literal ?? '',
          onTap: (partnerSchool) {
            context.read<DetailPageBloc>().update(partnerSchool: partnerSchool);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerSchool != current.detail.partnerSchool;
      },
    );
  }

  Widget buildPartnerJobs() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingSelect<Job>(
          children: Job.values,
          selected: state.detail.partnerJobs ?? [],
          labelBuilder: (partnerJob) => partnerJob.literal,
          onTap: (partnerJob) {
            final partnerJobs = List<Job>.from(state.detail.partnerJobs ?? []);
            if (partnerJobs.contains(partnerJob)) {
              partnerJobs.remove(partnerJob);
            } else {
              partnerJobs.add(partnerJob);
            }
            context.read<DetailPageBloc>().update(partnerJobs: partnerJobs);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerJobs != current.detail.partnerJobs;
      },
    );
  }

  Widget buildPartnerSalary() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<Salary?>(
          children: Salary.values,
          labelBuilder: (partnerSalary) => partnerSalary?.literal,
          selected: state.detail.partnerSalary,
          onTap: (partnerSalary) {
            context.read<DetailPageBloc>().update(partnerSalary: partnerSalary);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerSalary != current.detail.partnerSalary;
      },
    );
  }

  Widget buildPartnerAsset() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        final partnerAssetController = TextEditingController();
        partnerAssetController.addListener(() {
          context.read<DetailPageBloc>().update(partnerAsset: partnerAssetController.text);
        });
        return WeddingTextField(
          '',
          controller: partnerAssetController,
          keyboardType: TextInputType.number,
          postfix: Text(
            '??????',
            style: TextStyle(color: hintColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        );
      },
      buildWhen: (previous, current) {
        return false;
      },
    );
  }

  Widget buildPartnerSmoke() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<Smoke?>(
          children: Smoke.values,
          labelBuilder: (partnerSmoke) => partnerSmoke?.literal ?? '',
          selected: state.detail.partnerSmoke,
          onTap: (partnerSmoke) {
            context.read<DetailPageBloc>().update(partnerSmoke: partnerSmoke);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerSmoke != current.detail.partnerSmoke;
      },
    );
  }

  Widget buildPartnerDrink() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<Drink?>(
          children: Drink.values,
          labelBuilder: (partnerDrink) => partnerDrink?.literal ?? '',
          selected: state.detail.partnerDrink,
          onTap: (partnerDrink) {
            context.read<DetailPageBloc>().update(partnerDrink: partnerDrink);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerDrink != current.detail.partnerDrink;
      },
    );
  }

  Widget buildPartnerMarriage() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingRadio<Marriage?>(
          children: Marriage.values,
          labelBuilder: (partnerMarriage) => partnerMarriage?.literal ?? '',
          selected: state.detail.partnerMarriage,
          onTap: (partnerMarriage) {
            context.read<DetailPageBloc>().update(partnerMarriage: partnerMarriage);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerMarriage != current.detail.partnerMarriage;
      },
    );
  }

  Widget buildPartnerBody() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return WeddingSelect<BodyType>(
            children: BodyType.values,
            selected: state.detail.partnerBodies ?? [],
            labelBuilder: (partnerBody) => partnerBody.male,
            onTap: (partnerBody) {
              final partnerBodies = List<BodyType>.from(state.detail.partnerBodies ?? []);
              if (partnerBodies.contains(partnerBody)) {
                partnerBodies.remove(partnerBody);
              } else {
                if (5 <= partnerBodies.length) return;
                partnerBodies.add(partnerBody);
              }
              context.read<DetailPageBloc>().update(partnerBodies: partnerBodies);
            });
      },
      buildWhen: (previous, current) {
        return previous.detail.partnerBodies != current.detail.partnerBodies;
      },
    );
  }

  Widget buildPartnerDescription() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        final descriptionController = TextEditingController();
        descriptionController.addListener(() {
          context.read<DetailPageBloc>().update(partnerDescription: descriptionController.text);
        });
        return WeddingTextField('?????? ???????????? ???????????? ????????? ??????????????????.', controller: descriptionController, maxLength: 200, maxLines: 5);
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildButton() {
    return BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state) {
        return TextButton(
          child: const Text('??????', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.pop(context, state.detail);
          },
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      },
      buildWhen: (previous, current) {
        return false;
      },
    );
  }

  Widget buildDetailForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('???????????????', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(height: 32),
          const Text('?????? ?????? ??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildAsset(),
          const Text('?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildRealEstate(),
          const SizedBox(height: 20),
          const Text('????????????????????? ?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCertificate((state) => state.detail.familyCertificate, (context) {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
              if (image == null) return;
              context.read<DetailPageBloc>().update(familyCertificate: image.path);
            });
          }),
          const SizedBox(height: 20),
          const Text('??????????????? ?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCertificate((state) => state.detail.schoolCertificate, (context) async {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
              if (image == null) return;
              context.read<DetailPageBloc>().update(schoolCertificate: image.path);
            });
          }),
          const SizedBox(height: 20),
          const Text('??????????????? ?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCertificate((state) => state.detail.companyCertificate, (context) {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
              if (image == null) return;
              context.read<DetailPageBloc>().update(companyCertificate: image.path);
            });
          }),
          const SizedBox(height: 20),
          const Text('???????????? ?????? ?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCertificate((state) => state.detail.salaryCertificate, (context) {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
              if (image == null) return;
              context.read<DetailPageBloc>().update(salaryCertificate: image.path);
            });
          }),
          const SizedBox(height: 20),
          const Text('??????????????? ?????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildCertificate((state) => state.detail.vehicleCertificate, (context) {
            ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
              if (image == null) return;
              context.read<DetailPageBloc>().update(vehicleCertificate: image.path);
            });
          }),
          const SizedBox(height: 32),
          const Text('?????????', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('????????? ???????????? ????????? ?????????.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          buildPartnerAge(),
          const SizedBox(height: 20),
          buildPartnerHeight(),
          const SizedBox(height: 20),
          const Text('????????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerSchool(),
          const SizedBox(height: 20),
          const Text('?????? ??????(???????????? ??????)', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerJobs(),
          const SizedBox(height: 20),
          const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerSalary(),
          const SizedBox(height: 20),
          const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerAsset(),
          const SizedBox(height: 20),
          const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerSmoke(),
          const SizedBox(height: 20),
          const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerDrink(),
          const SizedBox(height: 20),
          const Text('????????????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerMarriage(),
          const SizedBox(height: 20),
          const Text('??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerBody(),
          const SizedBox(height: 20),
          const Text('????????? ?????? ??????', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          buildPartnerDescription(),
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
        backgroundColor: Colors.white,
        body: Column(
          children: [
            LinearProgressIndicator(
              value: 1,
              backgroundColor: inactiveColor,
              color: secondaryColor,
            ),
            Flexible(child: buildDetailForm(context)),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      create: (context) => DetailPageBloc(detail: detail),
    );
  }
}
