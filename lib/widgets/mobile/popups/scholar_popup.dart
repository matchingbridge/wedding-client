import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';

class ScholarPopupBloc extends Cubit<Scholar> {
  ScholarPopupBloc() : super(Scholar.onUniv);

  void update(Scholar scholar) {
    emit(scholar);
  }
}

class ScholarPopup extends StatelessWidget {
  final Scholar scholar;
  const ScholarPopup({Key? key, required this.scholar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocBuilder<ScholarPopupBloc, Scholar>(
        builder: (context, state) {
          return Padding(
            child: Column(
              children: [
                WeddingRadio<Scholar>(
                  children: Scholar.values,
                  labelBuilder: (scholar) => scholar.literal,
                  selected: state,
                  onTap: (scholar) {
                    context.read<ScholarPopupBloc>().update(scholar);
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
            padding: const EdgeInsets.all(20),
          );
        },
      ),
      create: (context) => ScholarPopupBloc(),
    );
  }
}
