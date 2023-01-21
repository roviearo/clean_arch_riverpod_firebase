import 'dart:async';

import 'package:clean_arch_riverpod_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:clean_arch_riverpod_firebase/src/features/jobs/domain/entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryScreenController extends AutoDisposeAsyncNotifier<void> {
  FutureOr<void> build() {}

  Future<bool> setEntry(Entry entry) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(databaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => database.setEntry(uid: currentUser.uid, entry: entry));
    return state.hasError == false;
  }
}

final entryScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EntryScreenController, void>(
        EntryScreenController.new);
