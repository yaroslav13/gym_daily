import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_daily/src/exceptions/authentication_exception.dart';
import 'package:gym_daily/src/features/common/hooks/use_async_error_toast.dart';
import 'package:gym_daily/src/providers/login/login_form_state_provider.dart';
import 'package:gym_daily/src/resources/assets.gen.dart';
import 'package:gym_daily/src/resources/translations.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_components/constants/gp_edge_insets.dart';

final class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  String _mapLogInErrorToMessage(Translations translations, Object error) {
    if (error is AuthenticationException) {
      return switch (error) {
        UnknownAuthenticationException() => translations.unknownError,
        InvalidEmailException() => translations.invalidEmail,
        UserDisabledException() => translations.userDisabled,
        UserNotFoundException() => translations.userNotFound,
        WrongPasswordException() => translations.invalidEmailOrPassword,
      };
    }

    return translations.unknownError;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginFormStateProvider);

    final pendingLogIn = useState<Future<void>?>(null);

    final logInSnapshot = useFuture(pendingLogIn.value);
    final isLoginInProgress =
        logInSnapshot.connectionState == ConnectionState.waiting;

    final translations = context.t;

    useAsyncErrorToast<void>(
      logInSnapshot,
      builder: (error) => _mapLogInErrorToMessage(translations, error),
    );

    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: GPEdgeInsets.scaffoldBody,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: GPEdgeInsets.horizontal,
                    child: SvgPicture.asset(Assets.images.dumbbell),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration()
                      .copyWith(labelText: context.t.email),
                  onChanged:
                      ref.read(loginFormStateProvider.notifier).onEmailChanged,
                ),
                TextFormField(
                  decoration: const InputDecoration()
                      .copyWith(labelText: context.t.password),
                  onChanged: ref
                      .read(loginFormStateProvider.notifier)
                      .onPasswordChanged,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: formState.isValid && !isLoginInProgress
                      ? () {
                          final logInAction = ref
                              .read(loginFormStateProvider.notifier)
                              .onLogIn();

                          pendingLogIn.value = logInAction;
                        }
                      : null,
                  child: Text(context.t.logIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
