import 'dart:math';

import 'package:clean_arch_riverpod_firebase/src/common_widgets/primary_button.dart';
import 'package:clean_arch_riverpod_firebase/src/constants/keys.dart';
import 'package:clean_arch_riverpod_firebase/src/constants/strings.dart';
import 'package:clean_arch_riverpod_firebase/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/async_valu_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(signInScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (p0, p1) {
            return Container(
              width: min(p1.maxWidth, 600),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                            Strings.signIn,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    key: emailPasswordButtonKey,
                    text: Strings.signInWithEamilAndPassword,
                    onPressed: state.isLoading
                        ? null
                        : () => context.goNamed(AppRoute),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
