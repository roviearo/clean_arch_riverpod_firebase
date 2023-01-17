import 'package:clean_arch_riverpod_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/localization/string_hardcoded.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/async_valu_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    final user = ref.watch(authRepositoryProvider).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading
            ? const CircularProgressIndicator()
            : Text('Account'.hardcoded),
        actions: [ActionTex],
      ),
    );
  }
}
