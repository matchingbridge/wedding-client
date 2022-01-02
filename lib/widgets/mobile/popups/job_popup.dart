import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/widgets/mobile/components/radio.dart';

class JobPopupBloc extends Cubit<Job> {
  JobPopupBloc() : super(Job.big);

  void update(Job job) {
    emit(job);
  }
}

class JobPopup extends StatelessWidget {
  const JobPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocBuilder<JobPopupBloc, Job>(
        builder: (context, state) {
          return Padding(
            child: Column(
              children: [
                WeddingRadio<Job>(
                  children: Job.values,
                  labelBuilder: (job) => job.literal,
                  selected: state,
                  onTap: (job) {
                    context.read<JobPopupBloc>().update(job);
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
      create: (context) => JobPopupBloc(),
    );
  }
}
