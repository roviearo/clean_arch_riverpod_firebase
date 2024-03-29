import 'package:clean_arch_riverpod_firebase/src/common_widgets/action_text_button.dart';
import 'package:clean_arch_riverpod_firebase/src/common_widgets/avatar.dart';
import 'package:clean_arch_riverpod_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:clean_arch_riverpod_firebase/src/localization/string_hardcoded.dart';
import 'package:clean_arch_riverpod_firebase/src/utils/alert_dialogs.dart';
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
        actions: [
          ActionTextButton(
              text: 'Logout'.hardcoded,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final logout = await showAlertDialog(
                        context: context,
                        title: 'Are you sure?'.hardcoded,
                        defaultActionText: 'Logout'.hardcoded,
                        cancelActionText: 'Cancel'.hardcoded,
                      );
                      if (logout == true) {
                        ref
                            .read(accountScreenControllerProvider.notifier)
                            .signOut();
                      }
                    }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: [
              if (user != null) ...[
                Avatar(
                  radius: 50,
                  photoUrl: user.photoURL,
                  borderColor: Colors.black54,
                  borderWidth: 2.0,
                ),
                const SizedBox(height: 8),
                if (user.displayName != null)
                  Text(
                    user.displayName!,
                    style: const TextStyle(color: Colors.white),
                  ),
                const SizedBox(height: 8),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
