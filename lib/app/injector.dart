import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/core.dart';
import 'features/sign_in/data/data.dart';
import 'features/sign_in/presentation/presentation.dart';
import 'features/sign_up/data/data.dart';
import 'features/sign_up/presentation/presentation.dart';


class Injector {
  final BuildContext context;

  Injector({required this.context});

  List<SingleChildWidget> providers() => [
        // External frameworks
        Provider(
            create: (_) =>
                FirebaseAuthAdapter(firebaseAuth: FirebaseAuth.instance)),
        Provider(create: (_) => FirebaseDatabaseAdapter()),
        Provider(
            create: (context) => RemoteSignIn(
                firebaseAuthClient: context.read<FirebaseAuthAdapter>())),

        // Usecases
        Provider(
            create: (context) => RemoteSignUp(
                firebaseAuthClient: context.read<FirebaseAuthAdapter>())),
        Provider(
            create: (context) => RemoteAddUser(
                databaseClient: context.read<FirebaseDatabaseAdapter>())),

        // Controllers
        ChangeNotifierProvider(
            create: (context) =>
                ValueNotifierSignInPresenter(signIn: context.read<RemoteSignIn>())),
        ChangeNotifierProvider(
            create: (context) => ValueNotifierSignUpPresenter(
                signUp: context.read<RemoteSignUp>(),
                addUser: context.read<RemoteAddUser>()))
      ];
}
