import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/services/mobile/auth_service.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';
import 'package:wedding/widgets/mobile/pages/complete_page.dart';
import 'package:wedding/widgets/mobile/pages/root_page.dart';
import 'package:wedding/widgets/mobile/pages/signup_page.dart';
import 'package:wedding/widgets/mobile/popups/error_popup.dart';

class SignInPageState {
  String email;
  String password;

  get isReady => email.isNotEmpty && password.isNotEmpty;

  SignInPageState({this.email = '', this.password = ''});

  SignInPageState copyWith({String? email, String? password}) {
    return SignInPageState(email: email ?? this.email, password: password ?? this.password);
  }
}

class SignInPageBloc extends Cubit<SignInPageState> {
  SignInPageBloc() : super(SignInPageState());

  void changeText({String? email, String? password}) {
    emit(state.copyWith(email: email, password: password));
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  Widget buildEmail() {
    return BlocBuilder<SignInPageBloc, SignInPageState>(
      builder: (context, state) {
        final emailController = TextEditingController(text: context.read<SignInPageBloc>().state.email);
        emailController.addListener(() {
          context.read<SignInPageBloc>().changeText(email: emailController.text);
        });
        return WeddingTextField(
          '이메일 입력',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          bottom: 8,
        );
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildPassword() {
    return BlocBuilder<SignInPageBloc, SignInPageState>(
      builder: (context, state) {
        final passwordController = TextEditingController(text: context.read<SignInPageBloc>().state.password);
        passwordController.addListener(() {
          context.read<SignInPageBloc>().changeText(password: passwordController.text);
        });
        return WeddingTextField('비밀번호 입력', controller: passwordController, obscureText: true, bottom: 0);
      },
      buildWhen: (previous, current) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocProvider(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 96),
                const Text('로그인', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 32),
                const Text('이메일', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                buildEmail(),
                const Text('비밀번호', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                buildPassword(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      '계정 찾기',
                      style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {},
                  ),
                ),
                BlocBuilder<SignInPageBloc, SignInPageState>(
                  builder: (context, state) {
                    return TextButton(
                      child: const Text(
                        '로그인',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      onPressed: () async {
                        try {
                          final response = await AuthService.signIn(
                            context.read<SignInPageBloc>().state.email,
                            context.read<SignInPageBloc>().state.password,
                          );
                          if (response == null) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CompletePage()));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RootPage()));
                          }
                        } catch (error) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(child: ErrorPopup(title: '로그인 실패', error: '$error')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return inactiveColor;
                          } else {
                            return secondaryColor;
                          }
                        }),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      ),
                    );
                  },
                  buildWhen: (previous, current) {
                    return previous.isReady != current.isReady;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '매칭 브릿지가 처음이신가요?',
                      style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () async {
                        final user = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                        if (user != null) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CompletePage()));
                        }
                        // context.read<AuthPageBloc>().changeType(AuthPageType.signup);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 40),
                Image.asset('assets/images/logo.png'),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
            padding: const EdgeInsets.all(20),
            physics: const ClampingScrollPhysics(),
          ),
          bottom: false,
        ),
      ),
      create: (_) => SignInPageBloc(),
    );
  }
}
