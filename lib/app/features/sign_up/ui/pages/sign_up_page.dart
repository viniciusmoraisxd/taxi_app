import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../../shared/shared.dart';
import '../../domain/entities/entities.dart';
import '../../presentation/presentation.dart';
import 'widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with UIErrorManager {
  late ValueNotifierSignUpPresenter presenter;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    presenter = context.read<ValueNotifierSignUpPresenter>();
    super.initState();
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
                    assetKey: 'signUpAsset',
                    image: AppImages.signUp,
                    title: "Criar conta",
                  ),
                  SignUpFormWidget(
                    height: constraints.maxHeight,
                    emailController: emailController,
                    nameController: nameController,
                    passwordController: passwordController,
                    confirmationPasswordController:
                        confirmationPasswordController,
                  ),
                  ValueListenableBuilder(
                    valueListenable:
                        context.read<ValueNotifierSignUpPresenter>(),
                    builder: (context, value, child) {
                      if (value is SignUpSuccess) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                          });
                        });
                      }

                      if (value is SignUpFailed) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          handleError(context, uiError: value.uiError);
                        });
                      }

                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: value is SignUpLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      final user = UserEntity(
                                          name: nameController.text.trim());

                                      await presenter(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          userEntity: user);
                                    }
                                  },
                            child: value is SignUpLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : const Text(
                                    "Registrar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Gotham-SSm",
                                    ),
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.04),
                            child: Column(
                              children: [
                                GestureDetector(
                                  key: const Key("signInButton"),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/sign_in", (route) => false);
                                  },
                                  child: RichText(
                                    key: const Key("Logar"),
                                    text: TextSpan(
                                        text: "Já tem uma conta?",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                            fontFamily: "Gotham-SSm"),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' Acessar',
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
