import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/features/sign_in/ui/ui.dart';

import '../../core/core.dart';
import '../../core/module.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

class SignInModule extends Module {
  @override
  void register(GetIt getIt) {
    getIt.registerSingleton<SignIn>(
        RemoteSignIn(firebaseAuthClient: getIt.get<FirebaseAuthClient>()));

    getIt.registerFactory<SignInPresenter>(
        () => ValueNotifierSignInPresenter(signIn: getIt.get<SignIn>()));
  }
}
