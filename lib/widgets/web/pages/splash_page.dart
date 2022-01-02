import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/widgets/splash_page.dart';
import 'package:wedding/widgets/web/pages/chats_page.dart';
import 'package:wedding/widgets/web/pages/matches_page.dart';
import 'package:wedding/widgets/web/pages/users_page.dart';

enum SplashPageWebTab { chat, match, user }

class SplashPageWebState {
  SplashPageWebTab splashPageWebTab;

  SplashPageWebState({required this.splashPageWebTab});
  SplashPageWebState copyWith({
    SplashPageWebTab? splashPageWebTab,
  }) {
    return SplashPageWebState(splashPageWebTab: splashPageWebTab ?? this.splashPageWebTab);
  }
}

class SplashPageWebBloc extends Cubit<SplashPageWebState> {
  SplashPageWebBloc() : super(SplashPageWebState(splashPageWebTab: SplashPageWebTab.user));

  void update({SplashPageWebTab? splashPageWebTab}) {
    emit(state.copyWith(splashPageWebTab: splashPageWebTab));
  }
}

class SplashPageWeb extends SplashPage {
  const SplashPageWeb({Key? key}) : super(key: key);

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SplashPageWebBloc, SplashPageWebState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text('Chats'),
                onTap: () {
                  context.read<SplashPageWebBloc>().update(splashPageWebTab: SplashPageWebTab.chat);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Match'),
                onTap: () {
                  context.read<SplashPageWebBloc>().update(splashPageWebTab: SplashPageWebTab.match);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Users'),
                onTap: () {
                  context.read<SplashPageWebBloc>().update(splashPageWebTab: SplashPageWebTab.user);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
        buildWhen: (previous, current) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SplashPageWebBloc, SplashPageWebState>(
            builder: (context, state) {
              return Text(state.splashPageWebTab.name);
            },
            buildWhen: (previous, current) {
              return previous.splashPageWebTab != current.splashPageWebTab;
            },
          ),
        ),
        drawer: buildDrawer(context),
        body: BlocBuilder<SplashPageWebBloc, SplashPageWebState>(
          builder: (context, state) {
            return IndexedStack(
              children: const [ChatsPage(), MatchesPage(), UsersPage()],
              index: state.splashPageWebTab.index,
            );
          },
          buildWhen: (previous, current) {
            return previous.splashPageWebTab != current.splashPageWebTab;
          },
        ),
      ),
      create: (context) => SplashPageWebBloc(),
    );
  }
}

SplashPage getSplashPage() => const SplashPageWeb();
