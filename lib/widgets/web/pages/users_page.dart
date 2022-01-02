import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/web/web_service.dart';

class UsersPageBloc extends Cubit<List<UserAuth>> {
  UsersPageBloc() : super([]) {
    getUsers();
  }

  Future<void> getUsers() async {
    final users = await WebService.getUsers();
    emit(users);
  }

  Future<void> review(int index, int authID) async {
    await WebService.review(authID);
    final newState = List<UserAuth>.from(state)..[index].reviewedAt = DateTime.now();
    emit(newState);
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  Widget buildReview(int index, UserAuth userAuth) {
    return BlocBuilder<UsersPageBloc, List<UserAuth>>(
      builder: (context, state) {
        if (userAuth.reviewedAt == null) {
          return TextButton(
            child: const Text('심사'),
            onPressed: () async {
              await context.read<UsersPageBloc>().review(index, userAuth.authID);
            },
          );
        } else {
          return const Text('심사 완료');
        }
      },
      buildWhen: (previous, current) {
        return previous[index].reviewedAt != current[index].reviewedAt;
      },
    );
  }

  Widget buildRow(int index, UserAuth userAuth) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Padding(child: Text(userAuth.email), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.name), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.phone), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.area.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.gender.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.marriage.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text('${userAuth.height}cm'), padding: const EdgeInsets.all(4)),
          Padding(child: Text('${userAuth.weight}kg'), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.smoke ? '흡연' : '비흡연'), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.drink ? '음주' : '비음주'), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.religion.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.gender == Gender.male ? userAuth.bodytype.male : userAuth.bodytype.female), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.character.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.scholar.literal), padding: const EdgeInsets.all(4)),
          Padding(child: Text(userAuth.job.literal), padding: const EdgeInsets.all(4)),
          buildReview(index, userAuth),
        ],
      ),
      scrollDirection: Axis.horizontal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocBuilder<UsersPageBloc, List<UserAuth>>(
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) => buildRow(index, state[index]),
            itemCount: state.length,
            separatorBuilder: (context, index) => const Divider(height: 16),
          );
        },
      ),
      create: (context) => UsersPageBloc(),
    );
  }
}
