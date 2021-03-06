import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';
import 'package:wedding/data/models.dart';
import 'package:wedding/services/mobile/auth_service.dart';
import 'package:wedding/services/mobile/user_service.dart';
import 'package:wedding/widgets/mobile/components/textfield.dart';
import 'package:wedding/widgets/mobile/pages/profile_page.dart';
import 'package:wedding/widgets/mobile/popups/error_popup.dart';

enum PhoneAuthorizeStep { init, sent, authorized, failed }

class SignUpPageState {
  String email;
  String password;
  String confirm;
  String name;
  String phone;
  String code;

  bool get isReady {
    return _isEmailValid && _isPasswordValid && _isConfirmValid && _isNameValid && phoneAuthorizeStep == PhoneAuthorizeStep.authorized;
  }

  get _isEmailValid => email.isNotEmpty;
  get _isPasswordValid => password.isNotEmpty;
  get _isConfirmValid => password == confirm;
  get _isNameValid => name.isNotEmpty;
  bool isEmailAuthorized;
  PhoneAuthorizeStep phoneAuthorizeStep;

  SignUpPageState({
    this.email = '',
    this.password = '',
    this.confirm = '',
    this.name = '',
    this.phone = '',
    this.code = '',
    this.isEmailAuthorized = false,
    this.phoneAuthorizeStep = PhoneAuthorizeStep.init,
  });

  SignUpPageState copyWith({
    String? email,
    String? password,
    String? confirm,
    String? name,
    String? phone,
    String? code,
    bool? isEmailAuthorized,
    PhoneAuthorizeStep? phoneAuthorizeStep,
  }) {
    return SignUpPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirm: confirm ?? this.confirm,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      isEmailAuthorized: isEmailAuthorized ?? this.isEmailAuthorized,
      phoneAuthorizeStep: phoneAuthorizeStep ?? this.phoneAuthorizeStep,
    );
  }
}

class SignUpPageBloc extends Cubit<SignUpPageState> {
  SignUpPageBloc() : super(SignUpPageState());

  void changeText({String? email, String? password, String? confirm, String? name, String? phone, String? code}) {
    emit(state.copyWith(email: email, password: password, confirm: confirm, name: name, phone: phone, code: code));
  }

  Future<void> checkRegistered(String email) async {
    final available = await UserService.checkEmail(email);
    emit(state.copyWith(isEmailAuthorized: available));
  }

  Future<void> requestCode(String phone) async {
    emit(state.copyWith(phoneAuthorizeStep: PhoneAuthorizeStep.sent));
  }

  Future<void> authorizeCode(String code) async {
    emit(state.copyWith(phoneAuthorizeStep: PhoneAuthorizeStep.authorized));
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  Widget buildEmail() {
    return Column(
      children: [
        BlocBuilder<SignUpPageBloc, SignUpPageState>(
          builder: (context, state) {
            final emailController = TextEditingController(text: context.read<SignUpPageBloc>().state.email);
            emailController.addListener(() {
              context.read<SignUpPageBloc>().changeText(email: emailController.text);
            });
            return WeddingTextField(
              '????????? ??????',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              postfix: GestureDetector(
                child: const Text(
                  '????????????',
                  style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  context.read<SignUpPageBloc>().checkRegistered(emailController.text);
                },
              ),
              bottom: 8,
            );
          },
          buildWhen: (previous, current) => false,
        ),
        BlocBuilder<SignUpPageBloc, SignUpPageState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state.isEmailAuthorized)
                  Text('??????????????? ??????????????????.', style: TextStyle(color: secondaryColor, fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(height: 20)
              ],
            );
          },
          buildWhen: (previous, current) {
            return previous.isEmailAuthorized != current.isEmailAuthorized;
          },
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildPassword() {
    return Column(
      children: [
        BlocBuilder<SignUpPageBloc, SignUpPageState>(
          builder: (context, state) {
            final passwordController = TextEditingController(text: context.read<SignUpPageBloc>().state.password);
            passwordController.addListener(() {
              context.read<SignUpPageBloc>().changeText(password: passwordController.text);
            });
            final confirmController = TextEditingController(text: context.read<SignUpPageBloc>().state.confirm);
            confirmController.addListener(() {
              context.read<SignUpPageBloc>().changeText(confirm: confirmController.text);
            });
            return Column(
              children: [
                WeddingTextField('???????????? ??????', controller: passwordController, obscureText: true, bottom: 0),
                WeddingTextField('???????????? ?????????', controller: confirmController, obscureText: true, bottom: 8),
              ],
            );
          },
          buildWhen: (previous, current) => false,
        ),
        BlocBuilder<SignUpPageBloc, SignUpPageState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state.password != state.confirm)
                  Text('??????????????? ???????????? ????????????.', style: TextStyle(color: errorColor, fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(height: 20),
              ],
            );
          },
          buildWhen: (previous, current) {
            return previous.password != current.password || previous.confirm != current.confirm;
          },
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildName() {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
      builder: (context, state) {
        final nameController = TextEditingController(text: context.read<SignUpPageBloc>().state.name);
        nameController.addListener(() {
          context.read<SignUpPageBloc>().changeText(name: nameController.text);
        });
        return WeddingTextField('?????? ??????', controller: nameController);
      },
      buildWhen: (previous, current) {
        return false;
      },
    );
  }

  Widget buildPhone() {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
      builder: (context, state) {
        final phoneController = TextEditingController(text: context.read<SignUpPageBloc>().state.phone);
        phoneController.addListener(() {
          context.read<SignUpPageBloc>().changeText(phone: phoneController.text);
        });
        final codeController = TextEditingController(text: context.read<SignUpPageBloc>().state.code);
        codeController.addListener(() {
          context.read<SignUpPageBloc>().changeText(code: codeController.text);
        });
        return Column(
          children: [
            WeddingTextField(
              '?????? ??????',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              bottom: 0,
              postfix: BlocBuilder<SignUpPageBloc, SignUpPageState>(
                builder: (context, state) {
                  return GestureDetector(
                    child: state.phoneAuthorizeStep == PhoneAuthorizeStep.init
                        ? const Text('???????????? ??????',
                            style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontSize: 14, fontWeight: FontWeight.w400))
                        : Text('?????????',
                            style: TextStyle(color: hintColor, decoration: TextDecoration.underline, fontSize: 14, fontWeight: FontWeight.w400)),
                    onTap: () {
                      context.read<SignUpPageBloc>().requestCode(phoneController.text);
                    },
                  );
                },
                buildWhen: (previous, current) {
                  return previous.phoneAuthorizeStep != current.phoneAuthorizeStep;
                },
              ),
            ),
            BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                Widget postfix = const SizedBox();
                if (state.phoneAuthorizeStep != PhoneAuthorizeStep.init) {
                  postfix = GestureDetector(
                    child: const Text('??????',
                        style: TextStyle(color: Colors.black, decoration: TextDecoration.underline, fontSize: 14, fontWeight: FontWeight.w400)),
                    onTap: () {
                      context.read<SignUpPageBloc>().authorizeCode(codeController.text);
                    },
                  );
                }
                return Column(
                  children: [
                    WeddingTextField(
                      '???????????? ??????',
                      backgroundColor: state.phoneAuthorizeStep == PhoneAuthorizeStep.init ? thumbnailColor : Colors.white,
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      postfix: postfix,
                      bottom: 8,
                    ),
                    if (state.phoneAuthorizeStep == PhoneAuthorizeStep.failed)
                      Text(
                        '??????????????? ???????????? ????????????.',
                        style: TextStyle(color: errorColor, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              },
              buildWhen: (previous, current) {
                return previous.phoneAuthorizeStep != current.phoneAuthorizeStep;
              },
            ),
          ],
        );
      },
      buildWhen: (previous, current) => false,
    );
  }

  Widget buildSignUpForm(BuildContext context) {
    return Column(
      children: [
        const Text('????????????', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        const Text('?????????', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        buildEmail(),
        const Text('????????????', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        buildPassword(),
        const Text('??????', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        buildName(),
        const Text('????????? ??????', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        buildPhone(),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget buildButton() {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
      builder: (blocContext, state) {
        return TextButton(
          child: const Text('??????', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
          onPressed: state.isReady
              ? () async {
                  final user = await Navigator.push(
                    blocContext,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        user: User.profile(email: state.email, name: state.name, phone: state.phone),
                        onButtonDown: (user) async {
                          try {
                            await AuthService.signUp(user, state.password);
                            Navigator.pop(context, user);
                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(child: ErrorPopup(title: '???????????? ??????', error: '$error')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                  if (user != null) {
                    Navigator.pop(blocContext, user);
                  }
                }
              : null,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: inactiveColor,
              color: secondaryColor,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildSignUpForm(context),
                    buildButton(),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: const EdgeInsets.all(20),
                physics: const ClampingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
      create: (context) => SignUpPageBloc(),
    );
  }
}
