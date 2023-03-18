import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';

class SignUpFormWidget extends StatefulWidget {
  final double height;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmationPasswordController;
  const SignUpFormWidget({
    Key? key,
    required this.height,
    required this.emailController,
    required this.passwordController,
    required this.confirmationPasswordController,
    required this.nameController,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: widget.nameController,
          label: "Nome",
          textInputType: TextInputType.name,
          prefix: const Icon(Icons.person_outline),
          validator: (String? value) =>
              InputValidators.requiredFieldValidator(value: value),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextFormField(
          controller: widget.emailController,
          label: "E-mail",
          textInputType: TextInputType.emailAddress,
          prefix: const Icon(Icons.mail_outline),
          validator: (String? value) =>
              InputValidators.emailFieldValidator(email: value),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextFormField(
          controller: widget.passwordController,
          prefix: const Icon(
            Icons.lock_outline,
          ),
          label: "Senha",
          obscureText: obscurePassword,
          validator: (String? value) =>
              InputValidators.requiredFieldValidator(value: value),
          suffix: IconButton(
            icon:
                Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextFormField(
          prefix: const Icon(
            Icons.lock_outline,
          ),
          label: "Repita sua senha",
          obscureText: obscurePassword,
          validator: (String? value) => InputValidators.compareFieldsValidator(
              fieldToCompare: widget.passwordController.text, field: value),
          suffix: IconButton(
            icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        SizedBox(
          height: widget.height * 0.04,
        )
      ],
    );
  }
}
