import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/match_service.dart';
import 'package:wedding/widgets/mobile/pages/chat_page.dart';
import 'package:wedding/widgets/mobile/pages/match_page.dart';

class HistoryPageState {
  List<Match> matched;
  List<Match> unmatched;

  HistoryPageState({this.matched = const [], this.unmatched = const []});
}

class HistoryPageBloc extends Cubit<HistoryPageState> {
  HistoryPageBloc() : super(HistoryPageState()) {
    getHistory();
  }

  Future<void> getHistory() async {
    final matched = await MatchService.getMatched();
    final unmatched = await MatchService.getUnmatched();

    emit(HistoryPageState(matched: matched, unmatched: unmatched));
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  Widget buildUser(BuildContext context, Match user) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          user.image(),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            );
          },
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  sliver: SliverToBoxAdapter(
                    child: SafeArea(
                      child: Column(
                        children: [
                          const Text('내가 한 요청', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500)),
                          Text('매칭 내역은 15일 후 자동 삭제됩니다.', style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      bottom: false,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                BlocBuilder<HistoryPageBloc, HistoryPageState>(
                  builder: (context, state) {
                    return SliverPadding(
                      sliver: SliverGrid.extent(
                        children: state.matched.map((user) => buildUser(context, user)).toList(),
                        crossAxisSpacing: 8,
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 8,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    );
                  },
                ),
                const SliverPadding(
                  sliver:
                      SliverToBoxAdapter(child: Text('나에게 온 요청', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500))),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                ),
                SliverPadding(
                  sliver: BlocBuilder<HistoryPageBloc, HistoryPageState>(
                    builder: (context, state) {
                      return SliverGrid.extent(
                        children: state.unmatched.map((user) => buildUser(context, user)).toList(),
                        crossAxisSpacing: 8,
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 8,
                      );
                    },
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ],
            ),
            Positioned(
              child: TextButton(
                child: const Text(
                  '만남 컨설팅 받기',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(secondaryColor),
                ),
              ),
              bottom: 100,
            ),
          ],
        ),
        color: primaryColor,
      ),
      create: (context) => HistoryPageBloc(),
    );
  }
}
