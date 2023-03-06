import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';

class FormContainerWidget extends StatefulWidget {
  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const FormContainerWidget({
    Key? key,
    required this.height,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: widget.emailController,
          label: "E-mail",
          textInputType: TextInputType.emailAddress,
          prefix: const Icon(Icons.mail_outline),
          // validator: (String? value) =>
          //     InputValidators.emailFieldValidator(email: value),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: widget.passwordController,
          prefix: const Icon(
            Icons.lock_outline,
          ),
          label: "Senha",
          obscureText: obscurePassword,
          // validator: (String? value) =>
          //     InputValidators.requiredFieldValidator(value: value),
          suffix: IconButton(
            icon:
                Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/forgot_password");
          },
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            alignment: Alignment.centerRight,
            child: Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: widget.height * 0.06,
        )
      ],
    );
  }
}
