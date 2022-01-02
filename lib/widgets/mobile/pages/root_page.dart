import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/widgets/mobile/pages/history_page.dart';
import 'package:wedding/widgets/mobile/pages/home_page.dart';
import 'package:wedding/widgets/mobile/pages/setting_page.dart';
import 'package:wedding/widgets/mobile/popups/match_popup.dart';

enum RootPageTab { home, history, profile }

class RootPageState {
  RootPageTab rootPageTab;
  RootPageState({
    required this.rootPageTab,
  });
  RootPageState copyWith({
    RootPageTab? rootPageTab,
  }) {
    return RootPageState(
      rootPageTab: rootPageTab ?? this.rootPageTab,
    );
  }
}

class RootPageBloc extends Cubit<RootPageState> {
  RootPageBloc() : super(RootPageState(rootPageTab: RootPageTab.home));

  void changeTab(RootPageTab rootPageTab) {
    emit(state.copyWith(rootPageTab: rootPageTab));
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  void onRequested(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(content: MatchPopup(), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))));
      },
    );
  }

  void onMatched(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<RootPageBloc, RootPageState>(
              builder: (context, state) {
                return IndexedStack(
                  children: const [
                    HomePage(),
                    HistoryPage(),
                    SettingPage(),
                  ],
                  index: state.rootPageTab.index,
                );
              },
              buildWhen: (previous, current) {
                return previous.rootPageTab != current.rootPageTab;
              },
            ),
            Positioned(
              child: SafeArea(
                child: Row(
                  children: [
                    BlocBuilder<RootPageBloc, RootPageState>(
                      builder: (context, state) {
                        return TextButton(
                          child: Image.asset('assets/images/history_${state.rootPageTab == RootPageTab.history ? 'on' : 'off'}.png', scale: 2),
                          onPressed: () {
                            context.read<RootPageBloc>().changeTab(RootPageTab.history);
                          },
                        );
                      },
                      buildWhen: (previous, current) {
                        return (previous.rootPageTab == RootPageTab.history) ^ (current.rootPageTab == RootPageTab.history);
                      },
                    ),
                    BlocBuilder<RootPageBloc, RootPageState>(
                      builder: (context, state) {
                        return TextButton(
                          child: Image.asset('assets/images/center.png', scale: 2),
                          onPressed: () {
                            context.read<RootPageBloc>().changeTab(RootPageTab.home);
                          },
                        );
                      },
                      buildWhen: (previous, current) {
                        return false;
                      },
                    ),
                    BlocBuilder<RootPageBloc, RootPageState>(
                      builder: (context, state) {
                        return TextButton(
                          child: Image.asset('assets/images/setting_${state.rootPageTab == RootPageTab.profile ? 'on' : 'off'}.png', scale: 2),
                          onPressed: () {
                            context.read<RootPageBloc>().changeTab(RootPageTab.profile);
                          },
                        );
                      },
                      buildWhen: (previous, current) {
                        return (previous.rootPageTab == RootPageTab.profile) ^ (current.rootPageTab == RootPageTab.profile);
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              bottom: 0,
            )
          ],
        ),
      ),
      create: (context) => RootPageBloc(),
    );
  }
}
