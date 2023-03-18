import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/core/core.dart';
import 'package:taxi_app/app/features/sign_in/sign_in_injector.dart';

import 'features/sign_up/sign_up_injector.dart';

class AppDependencies {
  static final getIt = GetIt.instance;

  static void configure() {
    getIt.registerLazySingleton<FirebaseAuthClient>(
        () => FirebaseAuthAdapter(firebaseAuth: FirebaseAuth.instance));
    getIt.registerLazySingleton<FirebaseFirestoreClient>(
        () => FirebaseDatabaseAdapter());

    SignUpModule().register(getIt);
    SignInModule().register(getIt);
  }
}
