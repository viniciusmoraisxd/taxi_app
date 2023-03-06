import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_app/app/shared/shared.dart';

import 'widgets/widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: const Text("Entrar"),
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
                                key: const Key("Registre-se"),
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
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
