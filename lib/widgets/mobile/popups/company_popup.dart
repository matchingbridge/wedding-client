import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';

class CompanyPopupBloc extends Cubit<Area> {
  CompanyPopupBloc() : super(Area.seoul);

  void update(Area area) {
    emit(area);
  }
}

class CompanyPopup extends StatelessWidget {
  const CompanyPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocProvider(
      child: BlocBuilder<CompanyPopupBloc, Area>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                WeddingTextField(
                  '회사명 입력',
                  controller: controller,
                ),
                WeddingRadio<Area>(
                  children: Area.values,
                  labelBuilder: (area) => area.literal,
                  selected: state,
                  onTap: (area) {
                    context.read<CompanyPopupBloc>().update(area);
                  },
                ),
                TextButton(
                  child: const Text('선택', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
                  onPressed: () {
                    Navigator.pop(context, {'company': controller.text, 'workplace': state.literal});
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            padding: const EdgeInsets.all(20),
            physics: const ClampingScrollPhysics(),
          );
        },
      ),
      create: (context) => CompanyPopupBloc(),
    );
  }
}
