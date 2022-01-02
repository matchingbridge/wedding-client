import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/widgets/mobile/popups/quit_chat_popup.dart';

class ChatPageState {}

class ChatPageBloc extends Cubit<ChatPageState> {
  ChatPageBloc() : super(ChatPageState());
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text(
                '나가기',
                style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                final answer = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                          content: QuitChatPopup(), shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))));
                    });
                if (answer == true) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '주선자에게 소개받기',
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: primaryColor,
        body: Column(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: '입력해주세요...', hintStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    TextButton(
                      child: const Text('전송', style: TextStyle(decoration: TextDecoration.underline, fontSize: 14, fontWeight: FontWeight.w500)),
                      onPressed: () {},
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: textFieldColor),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              decoration: BoxDecoration(
                color: chatColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
          ],
        ),
      ),
      create: (context) => ChatPageBloc(),
    );
  }
}
