import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../shared/shared.dart';

import '../presentation/presentation.dart';
import 'ui.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with UIErrorManager {
  late ValueNotifierSignInPresenter presenter;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    presenter = context.read<ValueNotifierSignInPresenter>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  HeaderWidget(
                    height: constraints.maxHeight,
                    image: AppImages.login,
                    title: "Login",
                    assetKey: "signInAsset",
                  ),
                  FormContainerWidget(
                      height: constraints.maxHeight,
                      emailController: emailController,
                      passwordController: passwordController),
                  ValueListenableBuilder(
                    valueListenable:
                        context.read<ValueNotifierSignInPresenter>(),
                    builder: (context, value, child) {
                      if (value is SignInSuccess) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, "/home", (route) => false);
                        });
                      }

                      if (value is SignInFailed) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          handleError(context, uiError: value.uiError);
                        });
                      }

                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: value is SignInLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await presenter(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                            child: value is SignInLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : const Text(
                                    "Entrar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Gotham-SSm",
                                    ),
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.09),
                            child: Column(
                              children: [
                                // const SizedBox(height: 6),
                                GestureDetector(
                                  key: const Key("signupButton"),
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/sign_up");
                                  },
                                  child: RichText(
                                    key: const Key("signUpLink"),
                                    text: TextSpan(
                                        text: "Não possui uma conta?",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                            fontFamily: "Gotham-SSm"),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: " Registre-se",
                                              style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
