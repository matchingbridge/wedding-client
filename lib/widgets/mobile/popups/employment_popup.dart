import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';

class EmploymentPopupBloc extends Cubit<Employment> {
  EmploymentPopupBloc() : super(Employment.regular);

  void update(Employment employment) {
    emit(employment);
  }
}

class EmploymentPopup extends StatelessWidget {
  const EmploymentPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocBuilder<EmploymentPopupBloc, Employment>(
        builder: (context, state) {
          return Padding(
              child: Column(
                children: [
                  WeddingRadio<Employment>(
                    children: Employment.values,
                    labelBuilder: (employment) => employment.literal,
                    selected: state,
                    onTap: (employment) {
                      context.read<EmploymentPopupBloc>().update(employment);
                    },
                  ),
                  TextButton(
                    child: const Text('선택', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      Navigator.pop(context, state);
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
              padding: const EdgeInsets.all(20));
        },
      ),
      create: (context) => EmploymentPopupBloc(),
    );
  }
}
