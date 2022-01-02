import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';

class SchoolPopupBloc extends Cubit<bool> {
  SchoolPopupBloc() : super(true);

  void update(bool main) {
    emit(main);
  }
}

class SchoolPopup extends StatelessWidget {
  const SchoolPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocProvider(
      child: BlocBuilder<SchoolPopupBloc, bool>(
        builder: (context, state) {
          return Padding(
            child: Column(
              children: [
                WeddingTextField('학교 입력', controller: controller),
                WeddingRadio<bool>(
                  children: const [true, false],
                  labelBuilder: (main) => main ? '본교' : '분교',
                  selected: state,
                  onTap: (main) {
                    context.read<SchoolPopupBloc>().update(main);
                  },
                ),
                TextButton(
                  child: const Text('선택', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
                  onPressed: () {
                    Navigator.pop(context, '${controller.text} ${state ? '본교' : '분교'}');
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
          );
        },
      ),
      create: (context) => SchoolPopupBloc(),
    );
  }
}
